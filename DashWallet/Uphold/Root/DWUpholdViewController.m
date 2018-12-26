//
//  Created by Andrew Podkovyrin
//  Copyright © 2018 Dash Core Group. All rights reserved.
//
//  Licensed under the MIT License (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  https://opensource.org/licenses/MIT
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "DWUpholdViewController.h"

#import "DWUpholdAuthViewController.h"
#import "DWUpholdClient.h"
#import "DWUpholdMainViewController.h"
#import "UIViewController+DWChildControllers.h"

NS_ASSUME_NONNULL_BEGIN

@interface DWUpholdViewController () <DWUpholdAuthViewControllerDelegate>

@end

@implementation DWUpholdViewController

+ (instancetype)controller {
    return [[self alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIViewController *controller = nil;
    BOOL authorized = [DWUpholdClient sharedInstance].authorized;
    if (authorized) {
        DWUpholdMainViewController *mainController = [DWUpholdMainViewController controller];
        controller = mainController;
    }
    else {
        DWUpholdAuthViewController *authController = [DWUpholdAuthViewController controller];
        authController.delegate = self;
        controller = authController;
    }
    [self dw_displayViewController:controller];
}

#pragma mark - DWUpholdAuthViewControllerDelegate

- (void)upholdAuthViewControllerDidAuthorize:(DWUpholdAuthViewController *)controller {
    DWUpholdMainViewController *mainController = [DWUpholdMainViewController controller];
    [self dw_performTransitionToViewController:mainController completion:nil];
}

@end

NS_ASSUME_NONNULL_END