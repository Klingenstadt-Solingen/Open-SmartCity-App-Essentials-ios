//
//  SelfSizedTableView.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 05.11.21.
//
import UIKit
/// The table view that sizes itself based on its `contentSize`.
/// This can be useful when the number of cells is limited and we don't want the cells to be reused.
/// You can put this table view in a scrollview in the storyboard with a placeholder height.
public class SelfSizedTableView: UITableView {
    public override var contentSize: CGSize {
        didSet { // basically the contentSize gets changed each time a cell is added
            // --> the intrinsicContentSize gets also changed leading to smooth size update
            if oldValue != contentSize {
                invalidateIntrinsicContentSize()
            }
        }
    }// end var contentSize

    public override var intrinsicContentSize: CGSize {
        CGSize(width: contentSize.width, height: contentSize.height)
    }// end var intrinsicContentSize
}// end class SelfSizedTableView
