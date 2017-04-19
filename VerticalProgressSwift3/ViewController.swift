//
//  ViewController.swift
//  VerticalProgressSwift3
//
//  Created by Vamshi Krishna on 19/04/17.
//  Copyright © 2017 VamshiKrishna. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    var scrollXpos: CGFloat = 0.0
    var scrollingView: UIScrollView?
    var numberOfPagesInScene: Int = 0
    var contentString: String = ""
    var progressView: ProgressView?

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollingView = UIScrollView(frame: CGRect(x: CGFloat(20), y: CGFloat(64), width: CGFloat(view.bounds.size.width - 20), height: CGFloat(view.bounds.size.height - 64)))
        scrollingView?.delegate = self
        scrollingView?.isPagingEnabled = true
        scrollingView?.bounces = false
        scrollingView?.showsVerticalScrollIndicator = false
        view.addSubview(scrollingView!)
        setUpReaderScreen()
    }
    
    func setUpReaderScreen(){
       
        if let fileURL = Bundle.main.url(forResource: "content", withExtension: "txt"),
            let data = NSData(contentsOf:fileURL) {
                contentString = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)! as String
        }
       
        let attributedContentString = NSMutableAttributedString(string: contentString)
        let framesetter: CTFramesetter? = CTFramesetterCreateWithAttributedString((attributedContentString))
        let targetSize = CGSize(width: CGFloat(view.frame.size.width), height: CGFloat(CGFloat.greatestFiniteMagnitude))
        let fitSize: CGSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter!, CFRangeMake(0, attributedContentString.length), nil, targetSize, nil)
    
        let textStorage = NSTextStorage(attributedString: attributedContentString)
        let textLayout = NSLayoutManager()
        textStorage.addLayoutManager(textLayout)
        var i: Int = 0
        numberOfPagesInScene = lround(Double(fitSize.height / scrollingView!.frame.size.height)) + 1
        let j: Int = lround(Double(fitSize.height / scrollingView!.frame.size.height))
        
        while i <= j {
            let targetSize = CGSize(width: CGFloat((scrollingView?.frame.size.width)! - 10), height: CGFloat((scrollingView?.frame.size.height)!))
            let textContainer = NSTextContainer(size: targetSize)
            textLayout.addTextContainer(textContainer)
            let textView = UITextView(frame: CGRect(x: CGFloat(0), y: CGFloat((scrollingView?.frame.size.height)! * CGFloat(i)), width: CGFloat((scrollingView?.frame.size.width)! - 10), height: CGFloat((scrollingView?.frame.size.height)!)), textContainer: textContainer)
            textView.tag = i
            textView.layer.borderWidth = 0
            textView.layer.borderColor = UIColor.blue.cgColor
            scrollingView?.addSubview(textView)
            i += 1
            textView.isEditable = false
        }
        var contentRect = CGRect.zero
        for view: UIView in (scrollingView?.subviews)! {
            contentRect = contentRect.union(view.frame)
        }
        scrollingView?.contentSize = contentRect.size
        
        progressView = ProgressView(frame: CGRect(x: CGFloat(view.frame.size.width - 10), y: CGFloat(64), width: CGFloat(4), height: CGFloat(view.frame.size.height - 64)))
        progressView?.layer.borderColor = UIColor(red: CGFloat(99.0 / 255.0), green: CGFloat(89.0 / 255.0), blue: CGFloat(141.0 / 255.0), alpha: CGFloat(1)).cgColor
        progressView?.layer.borderWidth = 1.0
        view.addSubview(progressView!)
        
        progressView?.percentDone = CGFloat(Float(Float(1) / Float(numberOfPagesInScene)))
        progressView?.setNeedsDisplay()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageHeight: CGFloat = view.frame.size.height
        let page: Int = Int(lround(Double((scrollView.contentOffset.y - pageHeight / 2) / pageHeight))) + 2
        progressView?.percentDone = CGFloat(Float(Float(page) / Float(numberOfPagesInScene)))
        progressView?.setNeedsDisplay()
    }

    override func viewDidLayoutSubviews() {
        scrollingView?.setContentOffset(CGPoint.zero, animated: false)
    }

}

