//
//  ViewController.m
//  MVMaterialViewDemo
//
//  Created by indianic on 21/05/15.
//  Copyright (c) 2015 MV. All rights reserved.
//

#import "ViewController.h"
#import "MVMaterialView.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet MVMaterialView *grayView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _grayView.layer.cornerRadius = 5.0;
    _grayView.layer.masksToBounds =  YES;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
