//
//  WaterVC.swift
//  Almanakh
//
//  Created by Khaled Ghoniem on 12/2/19.
//  Copyright © 2019 Khaled Ghoniem. All rights reserved.
//

import UIKit

class WaterVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let titlesF = [("Almanakh Pure Life Purified Water 500ml"),("Almanakh Pure Life Purified Water 500ml"),("Almanakh Pure Life Purified Water 500ml"),("Almanakh Pure Life Purified Water 500ml"),("Almanakh Pure Life Purified Water 500ml"),("Almanakh Pure Life Purified Water 500ml"),("Almanakh Pure Life Purified Water 500ml")]
    
    let desF = [("3 RS"),
                ("7 RS"),
                ("5 RS"),
                ("4 RS"),
                ("6 RS"),
                ("8 RS "),
                ("2 RS")]
    
    let desk = [("  3 "),
                   ("  7 "),
                   ("  5 "),
                   ("  4 "),
                   ("  7 "),
                   ("  5 "),
                   ("  4 "),
                   ("  6 "),
                   ("  8  "),
                   ("  2 ")]
    let imagesF = [UIImage(named: "image_water"),
                   UIImage(named: "image_water"),
                   UIImage(named: "image_water"),
                   UIImage(named: "image_water"),
                   UIImage(named: "image_water"),
                   UIImage(named: "image_water"),
                   UIImage(named: "image_water")]
    
    let imagesb = [UIImage(named: "ic_bascket"),
                   UIImage(named: "ic_bascket"),
                   UIImage(named: "ic_bascket"),
                   UIImage(named: "ic_bascket"),
                   UIImage(named: "ic_bascket"),
                   UIImage(named: "ic_bascket"),
                   UIImage(named: "ic_bascket")]

       
            override func viewDidLoad() {
                super.viewDidLoad()
                
                // delegate and dataSource
                collectionView.delegate = self
                collectionView.dataSource = self
                //        collectionView.backgroundColor = UIColor.green
                
            }
            
            
        @IBAction func back(_ sender: Any) {
            dismiss(animated: false, completion: nil)
        }
        // UICollectionViewDelegate, UICollectionViewDataSource functions
            func numberOfSections(in collectionView: UICollectionView) -> Int {
                return 1
            }
            
            func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return titlesF.count
            }
            
            func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
                
               
                let rotationAngleRadians = 90.0 * CGFloat(Double.pi/180.0)
                let rotationTransform = CATransform3DMakeRotation(rotationAngleRadians, 0, 0, 1)
                //  let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 100, 0)
                cell.layer.transform = rotationTransform
                
                // Define the final state (after the animation)
                UIView.animate(withDuration: 1.0, animations: { cell.layer.transform = CATransform3DIdentity })
                //let thisElement = colectionArr[indexPath.item]
                let cellIndex = indexPath.item
                
               
                
             
                
                cell.imageCell.image = imagesF[cellIndex]
                cell.labelTitle.text = titlesF[cellIndex]
                cell.labelDetails.text =  desF[cellIndex]
                cell.trashImg.image = imagesb[cellIndex]
                
                
                
                
                cell.contentView.layer.masksToBounds = true
                cell.backgroundColor = UIColor.white
                
                cell.layer.shadowColor = UIColor.gray.cgColor
                cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
                cell.layer.shadowRadius = 2.0
                cell.layer.shadowOpacity = 0.5
                cell.layer.masksToBounds = false
                cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
                
                
                
                return cell
            }
        //////
        
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let vc = storyboard?.instantiateViewController(withIdentifier: "WaterProductsVC") as? WaterProductsVC
            vc?.name = titlesF[indexPath.row]
            vc?.image = imagesF[indexPath.row]!
            vc?.name2 = desF[indexPath.row]
             vc?.name3 = desk[indexPath.row]
             self.present(vc!, animated: true, completion: nil)
            
            
            
        }
        
            func bestFrameSize() -> CGFloat {
                let frameHeight = self.view.frame.height
                let frameWidth = self.view.frame.width
                let bestFrameSize = (frameHeight > frameWidth ) ? frameHeight : frameWidth
                
                return bestFrameSize
            }
            
        }
        
        
        
        // extention for UICollectionViewDelegateFlowLayout
        extension WaterVC : UICollectionViewDelegateFlowLayout {
            
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
                return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
            }
            
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                let bounds = collectionView.bounds
                let heightVal = self.view.frame.height
                let widthVal = self.view.frame.width
                let cellsize = (heightVal < widthVal) ?  bounds.height/2 : bounds.width/2
             
                return CGSize(width: cellsize - 20   , height: 300 )
            }
            
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
                return 0
            }
            
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                return 10
            }
            
           
    }
