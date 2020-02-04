//
//  Card.swift
//  Accessibility
//
//  Created by Julia Conti Mestre on 03/02/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol CardDelegate {
    
    @objc optional func cardDidTapInside(card: Card)
    @objc optional func cardWillShowDetailView(card: Card)
    @objc optional func cardDidShowDetailView(card: Card)
    @objc optional func cardWillCloseDetailView(card: Card)
    @objc optional func cardDidCloseDetailView(card: Card)
    @objc optional func cardIsShowingDetail(card: Card)
    @objc optional func cardIsHidingDetail(card: Card)
    @objc optional func cardDetailIsScrolling(card: Card)
}

open class Card: UITableViewCell, CardDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var numberOfPointsLabel: UILabel!
    @IBOutlet weak var firstCountryLabel: UILabel!
    @IBOutlet weak var secondCountryLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    //Card Images
    @IBOutlet weak var ringImage: UIImageView!
    @IBOutlet weak var cornerImage: UIImageView!
    @IBOutlet weak var firstCountryImage: UIImageView!
    @IBOutlet weak var secondCountryImage: UIImageView!
    
    //Private Vars
    fileprivate var tap = UITapGestureRecognizer()
    var detailVC = DetailViewController()
    weak var superVC: UIViewController?
    var originalFrame = CGRect.zero
    public var insets = CGFloat()
    var isPresenting = false
    
    public var delegate: CardDelegate?
    
    //Card design
    let cardRadius = 8
    
    //MARK: - Layout
    open func layout(animating: Bool = true){ }
    
    func shouldPresent( _ contentViewController: UIViewController?, from superVC: UIViewController?, fullscreen: Bool = false) {
        if detailVC.children.count > 0 {
            let viewControllers:[UIViewController] = detailVC.children
            for viewContoller in viewControllers{
                viewContoller.willMove(toParent: nil)
                viewContoller.view.removeFromSuperview()
                viewContoller.removeFromParent()
            }
        }
        detailVC.isViewAdded = false
        if let content = contentViewController{
            self.superVC = superVC
            detailVC.addChild(content)
            detailVC.detailView = content.view
            detailVC.card = self
            detailVC.delegate = self.delegate
            detailVC.isFullscreen = fullscreen
        }
    }
    
    //MARK: - View Life Cycle
//    public override init(frame: CGRect) {
//        super.init(frame: frame)
//        initialize()
//    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    open func initialize() {
//        log("CARD: Initializing Card")
        
        // Tap gesture init
        self.addGestureRecognizer(tap)
        tap.delegate = self
        tap.cancelsTouchesInView = false
       
        detailVC.transitioningDelegate = self
        
        // Adding Subviews
//        self.addSubview(backgroundIV)
        
//        backgroundIV.isUserInteractionEnabled = true
//        
//        if backgroundIV.backgroundColor == nil {
//            backgroundIV.backgroundColor = UIColor.white
////            super.backgroundColor = UIColor.clear
//        }
        
        //Set the card labels and images here
    }
    
    
    //Opens the card if detail view is set.
    open func open(){
        if let superview = self.superview {
            originalFrame = superview.convert(self.frame, to: nil)
//            log("CARD: open() called, setting original frame to ---> \(originalFrame)" )
        }
        shrinkAnimated()
        self.cardTapped()
    }

    //MARK: - Actions
    
    @objc func cardTapped() {
        self.delegate?.cardDidTapInside?(card: self)
        resetAnimated()
        
        if let vc = superVC {
//            log("CARD: Card tapped, Presenting DetailViewController")
            vc.present(self.detailVC, animated: true, completion: nil)
        }
    }

    
    //MARK: - Animations
    private func shrinkAnimated() {
        
        UIView.animate(withDuration: 0.2, animations: { self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95) })
    }
    
    private func resetAnimated() {
        
        UIView.animate(withDuration: 0.2, animations: { self.transform = CGAffineTransform.identity })
    }
    
    func goParallax() {
        let amount = 20
        
        let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontal.minimumRelativeValue = -amount
        horizontal.maximumRelativeValue = amount
        
        let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        vertical.minimumRelativeValue = -amount
        vertical.maximumRelativeValue = amount
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontal, vertical]
        self.addMotionEffect(group)
    }
}

//MARK: - Gesture Delegate
extension Card {
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        cardTapped()
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetAnimated()
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let superview = self.superview {
            originalFrame = superview.convert(self.frame, to: nil)
//            log("CARD: Card's touch began, setting original frame to ---> \(originalFrame)" )
        }
        shrinkAnimated()
    }
}

 //MARK: - Transition Delegate
extension Card: UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animator(presenting: true, from: self)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animator(presenting: false, from: self)
    }
    
}
