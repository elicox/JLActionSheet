//
//  JLViewController.m
//  JLActionSheet
//
//  Created by Jason Loewy on 1/31/13.
//  Copyright (c) 2013 Jason Loewy. All rights reserved.
//

#import "JLViewController.h"

#import "JLActionSheet.h"

@interface JLViewController () <JLActionSheetDelegate>

@property (nonatomic, strong) JLActionSheet* actionSheet;

@property (weak, nonatomic) IBOutlet UISegmentedControl *itemCountSegmentController;
@property (weak, nonatomic) IBOutlet UISegmentedControl *styleSegmentedController;
@property (weak, nonatomic) IBOutlet UISwitch *showCancelButton;
@property (weak, nonatomic) IBOutlet UISwitch *allowTapSwitch;

@property (weak, nonatomic) IBOutlet UILabel *selectedLabel;

@end

@implementation JLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
#pragma mark - Demo Convenience Methods 

- (JLStyle) getSelectedStyle
{
    JLStyle selectedStyle;
    // Determine which style to be used
    if (_styleSegmentedController.selectedSegmentIndex == 1)
        selectedStyle = SUPERCLEAN;
    else if (_styleSegmentedController.selectedSegmentIndex == 2)
        selectedStyle = FERRARI;
    else if (_styleSegmentedController.selectedSegmentIndex == 3)
        selectedStyle = CLEANBLUE;
    else
        selectedStyle = STEEL;
    
    return selectedStyle;
}

- (NSMutableArray*) getButtonTitles
{
    NSMutableArray* buttonTitles = [[NSMutableArray alloc] initWithCapacity:4];
    for (NSInteger i = 0; i < (_itemCountSegmentController.selectedSegmentIndex + 1); i++)
    {
        switch (i) {
            case 0:
                buttonTitles[0] = @"One";
                break;
            case 1:
                buttonTitles[1] = @"Two";
                break;
            case 2:
                buttonTitles[2] = @"Three";
                break;
            case 3:
                buttonTitles[3] = @"Four";
                break;
            default:
                break;
        }
    }
    return buttonTitles;
}

#pragma mark - 
#pragma mark - Presentation Methods

- (IBAction)presentInView:(id)sender
{
    NSMutableArray* buttonTitles = [self getButtonTitles];
    NSString* cancelTitle   = [_showCancelButton isOn] ? @"Cancel" : nil;
    _actionSheet            = [JLActionSheet sheetWithTitle:nil delegate:self cancleButtonTitle:cancelTitle otherButtonTitles:buttonTitles];
    [_actionSheet allowTapToDismiss:[_allowTapSwitch isOn]];
    [_actionSheet setStyle:[self getSelectedStyle]];
    [_actionSheet showOnViewController:self];
}

- (IBAction)presentFromNavBar:(UIBarButtonItem *)sender
{
    NSMutableArray* buttonTitles = [self getButtonTitles];
    NSString* cancelTitle   = [_showCancelButton isOn] ? @"Cancel" : nil;
    
    _actionSheet            = [JLActionSheet sheetWithTitle:nil delegate:self cancleButtonTitle:cancelTitle otherButtonTitles:buttonTitles];
    [_actionSheet allowTapToDismiss:[_allowTapSwitch isOn]];
    [_actionSheet setStyle:[self getSelectedStyle]];
    [_actionSheet showFromBarItem:sender onViewController:self];
}

#pragma mark - 
#pragma mark - JLActionSheet Delegate

- (void) actionSheet:(JLActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Clicked Button: %d Title: %@", buttonIndex, [actionSheet titleAtIndex:buttonIndex]);
    [_selectedLabel setText:[actionSheet titleAtIndex:buttonIndex]];
    if (buttonIndex == actionSheet.cancelButtonIndex)
        NSLog(@"Is cancel button");
}

- (void) actionSheet:(JLActionSheet *)actionSheet didDismissButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Did dismiss");
}

@end
