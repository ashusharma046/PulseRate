//
//  EnterUserDetailsViewController.h
//  PulseRate
//
//  Created by Aneesh on 09/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnterUserDetailsViewController : UIViewController<UITextFieldDelegate>{
    
    IBOutlet UITextField *age;
    IBOutlet UITextField *weight;
    IBOutlet UITextField *height;

}
@property(strong,nonatomic) IBOutlet UITextField *age;
@property(strong,nonatomic) IBOutlet UITextField *weight;
@property(strong,nonatomic) IBOutlet UITextField *height;
-(IBAction)done:(id)sender;
-(IBAction)back:(id)sender;
@end
