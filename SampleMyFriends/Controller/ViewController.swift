//
//  ViewController.swift
//  SampleMyFriends
//
//  Created by apple on 30/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /***********Declaration***********/
    //registerTbl view
    var myFriendsTbl = UITableView()
    var myFriendsTblCellIdentifier = "FriendsListCell"
    //headerView
    var headerView = UIView()
    //Header Title Label
    var titleLbl = UILabel()
    //Header TextField for Search
    var searchTxtFld = UITextField()
    //headerHeightConstraint
    var headerHeightConstraint = NSLayoutConstraint()
    //finishedAnimation
    /**Created to fix animation issues**/
    var finishedAnimation = false
    
    //Access permission View :- Bottom Sheet
    var bottomSheetBgView = UIControl()
    var bottomView = UIView()
    var bottomSheetContinueBtn = UIControl()
    
    //View Model
    private let viewModel = MyFriendsViewModel()
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setupHeaderView
        self.setupHeaderView()
        //setUpMyFriendsView
        self.setUpMyFriendsView()
        
        //readJsonFile
        viewModel.readJsonFile()
    }
    
    //MARK:- viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK:- viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //Rounded cornor
        bottomView.roundCorners(corners: [.topLeft], radius: 90.0)
        bottomSheetContinueBtn.roundCorners(corners: [.topLeft,.bottomLeft], radius: 10.0)
    }
}

//MARK:- Design
extension ViewController {
    
    //MARK: setupHeaderView
    fileprivate func setupHeaderView() {
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        //headerView
        headerView = {
            let view = UIView()
            view.backgroundColor = UIColor.clear
            return view
        }()
        self.view.addSubview(headerView)
        headerView.anchor(top: self.view.safeTopAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor, centerX: nil , centerY: nil, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0), center: (0,0))
        headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 180)
        headerHeightConstraint.isActive = true
        
        //titleLbl
        titleLbl = {
            let lbl = UILabel()
            lbl.backgroundColor = UIColor.clear
            lbl.text = viewModel.headerTitle
            lbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            lbl.adjustsFontSizeToFitWidth = true
            return lbl
        }()
        headerView.addSubview(titleLbl)
        titleLbl.changeFrame(toOriginX: 25, toOriginY: 60, toWidth: 160, toHeight: 35, font: UIFont.setAppFont(28), alignment: .left, duration: 0.5)
        
        //Setting up favouriteBtn
        let favouriteBtn: UIButton = {
            let btn = UIButton()
            //            btn.addTarget(self, action: #selector(backBtnAction), for: .touchUpInside)
            btn.setImage(UIImage(named: "StarImage"), for: .normal)
            btn.contentHorizontalAlignment = .left
            return btn
        }()
        headerView.addSubview(favouriteBtn)
        favouriteBtn.anchor(top: headerView.topAnchor, leading: headerView.leadingAnchor, bottom: nil, trailing: nil, centerX: nil, centerY: nil, padding: UIEdgeInsets(top: 12, left: 25, bottom: 0, right: 0), size: CGSize(width: 24, height: 24), center: (0,0))
        
        //Setting up plusBtn
        let plusBtn: UIButton = {
            let btn = UIButton()
            //            btn.addTarget(self, action: #selector(backBtnAction), for: .touchUpInside)
            btn.setImage(UIImage(named: "PlusImage"), for: .normal)
            btn.contentHorizontalAlignment = .left
            return btn
        }()
        headerView.addSubview(plusBtn)
        plusBtn.anchor(top: headerView.topAnchor, leading: nil, bottom: nil, trailing: headerView.trailingAnchor, centerX: nil, centerY: nil, padding: UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 25), size: CGSize(width: 24, height: 24), center: (0,0))
        
        //searchTxtFld
        searchTxtFld = {
            let txtFld = UITextField()
            txtFld.backgroundColor = UIColor.white
//            txtFld.placeholder = "Search"
            txtFld.delegate = self
            txtFld.autocorrectionType = .no
            txtFld.autocapitalizationType = .none
            txtFld.keyboardType = .default
            txtFld.textAlignment = .left
            txtFld.font = UIFont.setAppFont(14)
            return txtFld
        }()
        headerView.addSubview(searchTxtFld)
        searchTxtFld.anchor(top: nil, leading: headerView.leadingAnchor, bottom: headerView.bottomAnchor, trailing: headerView.trailingAnchor, centerX: nil , centerY: nil, padding: UIEdgeInsets(top: 0, left: 25, bottom: 15, right: 25), size: CGSize(width: 0, height: 43), center: (0,0))
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
        let searchImageView: UIImageView = {
            let imageview = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
            imageview.image = UIImage(named:"SearchImage")
            return imageview
        }()
        searchImageView.center = paddingView.center
        paddingView.addSubview(searchImageView)
        searchTxtFld.leftView = paddingView
        searchTxtFld.leftViewMode = .always
        searchTxtFld.addTarget(self, action: #selector(self.textIsChanging(_ :)), for: .editingChanged)
        
    }
    
    //MARK: setUpMyFriendsView
    func setUpMyFriendsView() {
        //myFriendsTbl
        myFriendsTbl = {
            let tableView = UITableView()
            tableView.backgroundColor = UIColor.clear
            tableView.delegate = self
            tableView.dataSource = self
            tableView.isScrollEnabled = true
            tableView.separatorStyle = .none
            tableView.showsHorizontalScrollIndicator = false
            tableView.showsVerticalScrollIndicator = false
            tableView.contentInsetAdjustmentBehavior = .never
            return tableView
        }()
        self.view.addSubview(myFriendsTbl)
        myFriendsTbl.tableFooterView = UIView(frame: .zero)
        myFriendsTbl.anchor(top: headerView.bottomAnchor, leading: self.view.leadingAnchor, bottom: self.view.safeBottomAnchor, trailing: self.view.trailingAnchor, centerX: nil, centerY: nil, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0), center: (0,0))
        
        myFriendsTbl.register(FriendsListCells.self, forCellReuseIdentifier: myFriendsTblCellIdentifier)
        
        //setUpBottomSheetView
        self.setUpBottomSheetView()
    }
}

//MARK:- setUpBottomSheetView
extension ViewController {
    func setUpBottomSheetView(){
        //bottomSheetBgView
        bottomSheetBgView = {
            let control = UIControl()
            control.backgroundColor = .clear
            control.addTarget(self, action: #selector(hideBottomSheetView), for: .touchUpInside)
            return control
        }()
        self.view.addSubview(bottomSheetBgView)
        bottomSheetBgView.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor, centerX: nil, centerY: nil, padding:  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize.zero, center: (0,0))
        bottomSheetBgView.isHidden = true
        
        //bottomView
        bottomView = {
            let view = UIView()
            view.backgroundColor = #colorLiteral(red: 0.9685460925, green: 0.9686813951, blue: 0.9685032964, alpha: 1)
            return view
        }()
        bottomSheetBgView.addSubview(bottomView)
        bottomView.anchor(top: nil, leading: bottomSheetBgView.leadingAnchor, bottom: bottomSheetBgView.bottomAnchor, trailing: bottomSheetBgView.trailingAnchor, centerX: nil, centerY: nil, padding:  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize.init(width: 0, height: 310), center: (0,0))
        bottomView.isHidden = true
        
        //topSliderView
        let topSliderView:UIView = {
            let view = UIView()
            view.backgroundColor = #colorLiteral(red: 0.7842469811, green: 0.784357965, blue: 0.7842119336, alpha: 1)
            view.layer.cornerRadius = 1.0
            view.clipsToBounds = true
            return view
        }()
        bottomView.addSubview(topSliderView)
        topSliderView.anchor(top: bottomView.topAnchor, leading: nil, bottom: nil, trailing: nil, centerX: bottomView.centerXAnchor, centerY: nil, padding:  UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0), size: CGSize.init(width: 30, height: 2.0), center: (0,0))
        
        //rightPadView
        let rightPadView:UIView = {
            let view = UIView()
            view.backgroundColor = #colorLiteral(red: 0.7842469811, green: 0.784357965, blue: 0.7842119336, alpha: 1)
            return view
        }()
        bottomView.addSubview(rightPadView)
        rightPadView.anchor(top: bottomView.topAnchor, leading: nil, bottom: bottomView.bottomAnchor, trailing: bottomView.trailingAnchor, centerX: nil, centerY: nil, padding:  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize.init(width: 80, height: 0), center: (0,0))
        
        //contactImg
        let contactImg:UIImageView = {
            let imageView = UIImageView()
            imageView.backgroundColor = .clear
            imageView.image = UIImage(named:"contactImage")
            return imageView
        }()
        bottomView.addSubview(contactImg)
        contactImg.anchor(top: bottomView.topAnchor, leading: nil, bottom: nil, trailing: nil, centerX: rightPadView.leadingAnchor, centerY: nil, padding:  UIEdgeInsets(top: 55, left: 0, bottom: 0, right: 0), size: CGSize.init(width: 110, height: 110), center: (0,0))
        
        //bottomSheetContinueBtn
        bottomSheetContinueBtn = {
            let control = UIControl()
            control.backgroundColor = #colorLiteral(red: 0.8425492644, green: 0.6285782456, blue: 0.156286329, alpha: 1)
            control.addTarget(self, action: #selector(hideBottomSheetView), for: .touchUpInside)
            return control
        }()
        bottomView.addSubview(bottomSheetContinueBtn)
        bottomSheetContinueBtn.anchor(top: nil, leading: bottomView.leadingAnchor, bottom: bottomView.safeBottomAnchor, trailing: bottomView.trailingAnchor, centerX: nil, centerY: nil, padding:  UIEdgeInsets(top: 0, left: 25, bottom: 10, right: 0), size: CGSize.init(width: 0, height: 50), center: (0,0))
        
        //confirmLbl
        let confirmLbl:UILabel = {
            let label = UILabel()
            label.font = UIFont.setAppFont(16)
            label.textAlignment = .natural
            label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.text = "Confirm"
            label.adjustsFontSizeToFitWidth = true
            return label
        }()
        bottomSheetContinueBtn.addSubview(confirmLbl)
        confirmLbl.anchor(top: nil, leading: bottomSheetContinueBtn.leadingAnchor, bottom: nil, trailing: bottomSheetContinueBtn.centerXAnchor, centerX: nil, centerY:bottomSheetContinueBtn.centerYAnchor , padding:  UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 0), size: CGSize.init(width: 0, height: 20), center: (0,0))
        
        //arrowImg
        let arrowImg:UIImageView = {
            let imageView = UIImageView()
            imageView.backgroundColor = .clear
            imageView.image = UIImage(named:"continueArrow")
            return imageView
        }()
        bottomSheetContinueBtn.addSubview(arrowImg)
        arrowImg.anchor(top: nil, leading: nil, bottom: nil, trailing: bottomSheetContinueBtn.trailingAnchor, centerX: nil, centerY:bottomSheetContinueBtn.centerYAnchor , padding:  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20), size: CGSize.init(width: 20, height: 15), center: (0,0))
        
        //openAccessLbl
        let openAccessLbl:UILabel = {
            let label = UILabel()
            label.font = UIFont.setAppFontBold(28)
            label.textAlignment = .natural
            label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.text = "Open access"
            label.adjustsFontSizeToFitWidth = true
            return label
        }()
        bottomView.addSubview(openAccessLbl)
        openAccessLbl.anchor(top: nil, leading: bottomView.leadingAnchor, bottom: contactImg.centerYAnchor, trailing: contactImg.leadingAnchor, centerX: nil, centerY: nil, padding:  UIEdgeInsets(top: 0, left: 25, bottom: 2, right: 5), size: CGSize.init(width: 0, height: 50), center: (0,0))
        
        //accessDescriptionLbl
        let accessDescriptionLbl:UILabel = {
            let label = UILabel()
            label.font = UIFont.setAppFont(16)
            label.textAlignment = .natural
            label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            label.text = "And your friends to pay you back next time"
            label.adjustsFontSizeToFitWidth = true
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            return label
        }()
        bottomView.addSubview(accessDescriptionLbl)
        accessDescriptionLbl.anchor(top: contactImg.centerYAnchor, leading: bottomView.leadingAnchor, bottom: nil, trailing: contactImg.leadingAnchor, centerX: nil, centerY: nil, padding:  UIEdgeInsets(top: 2, left: 25, bottom: 0, right: 5), size: CGSize.init(width: 0, height: 50), center: (0,0))
    }
    
    //MARK: showBottomSheetView
    func showBottomSheetView() {
        self.view.endEditing(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.bottomSheetBgView.isHidden = false
            self.bottomView.animateView("fromTop") {
                self.bottomView.isHidden = false
            }
        }
    }
    
    //MARK: hideBottomSheetView
    @objc func hideBottomSheetView() {
        self.view.endEditing(true)
        self.bottomSheetBgView.isHidden = true
        self.bottomView.isHidden = true
    }
}

//MARK:- UITextFieldDelegate & Actions
extension ViewController: UITextFieldDelegate {
    //MARK: Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    //MARK: textIsChanging
    @objc func textIsChanging(_ textField: UITextField) {
        let searchText = textField.text!
        let filtered = viewModel.myFriendArray.filter {
            return $0.title?.range(of: searchText, options: [.caseInsensitive]) != nil || $0.distance?.range(of: searchText, options: .caseInsensitive) != nil
        }
        //Check for Any filtered Array
        if filtered.count > 0 {
            viewModel.myFriendListArray = filtered
        } else {
            //when no search data found
            if searchText.count > 0 {
                //Hiding keyboard
                self.view.endEditing(true)
                self.popupAlert(title: "", message: viewModel.alertMessage, actionTitles: ["OK"], actions:[{action1 in
                    //Clearing text
                    self.searchTxtFld.text = ""
                    //Hiding bottomsheets
                    self.hideBottomSheetView()
                    }])
            }
            viewModel.myFriendListArray = viewModel.myFriendArray
        }
        //Reloading the table
        self.myFriendsTbl.reloadData()
        //Move to top
        self.myFriendsTbl.setContentOffset(.zero, animated: true)
    }
}

//MARK:- UITableViewDelegate and datasource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: tableView: numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.myFriendListArray.count
    }
    
    //MARK: tableView: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //table view cell
        let cell = tableView.dequeueReusableCell(withIdentifier: myFriendsTblCellIdentifier, for: indexPath) as! FriendsListCells
        //Check Array has values or not
        if viewModel.myFriendListArray.count != 0 {
            //Setting values for title
            if let title = viewModel.myFriendListArray[indexPath.row].title {
                cell.titleLbl.text = title
            }
            //Setting values for distance
            if let distance = viewModel.myFriendListArray[indexPath.row].distance {
                cell.distanceLbl.text = distance
            }
            //Setting values for profile image from Cache
            if let profileImage = viewModel.myFriendListArray[indexPath.row].imageHref {
                ImageCache.getImages(imageURL: profileImage) { (downloadedImage) in
                    cell.profileImg.image = downloadedImage
                } 
            }
        } else {
            print("No data found")
        }
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    //MARK: tableView: heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    //MARK: tableView: willDisplay cell
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if finishedAnimation {
                UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
                    self.headerHeightConstraint.constant = 180
                    self.titleLbl.changeFrame(toOriginX: 25, toOriginY: 60, toWidth: 160, toHeight: 35, font: UIFont.setAppFont(28), alignment: .left, duration: 0.5)
                    self.view.layoutIfNeeded()
                }, completion: { finished in
                    self.finishedAnimation = false
                })
            }
        } else if indexPath.row == (viewModel.myFriendArray.count - 1) {
            self.showBottomSheetView()
        }
    }
    
    //MARK: scrollView
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            if !finishedAnimation {
                UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
                    self.headerHeightConstraint.constant = 130
                    self.titleLbl.changeFrame(toOriginX: (self.view.center.x - 80), toOriginY: 10, toWidth: 160, toHeight: 35, font: UIFont.setAppFont(22), alignment: .center, duration: 0.5)
                    
                    self.view.layoutIfNeeded()
                }, completion: { finished in
                    self.finishedAnimation = true
                })
            }
        }
    }
}
