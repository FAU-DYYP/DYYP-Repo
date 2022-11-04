Original App Design Project
===

# DYYP
### Group 14

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
DYYP is a cryptocurrency focused app: it monitors the crpyto market for prices. Users can personalize their feed, a profile, and a simulated crypto wallet. The user can also seen in-depth information about a specific coin in a seperate view.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category: Finance News**
- **Mobile: iOS, modern**
- **Story: A user can browse the app to monitor crypto markets, as well as their own holdings.**
- **Market: 21-40 year olds interested in finance**
- **Habit: To monitor their holdings and prices, Users would browse the app daily when the market is slow and every few minutes when there are rapid changes.**
- **Scope: More personal and focused, there is no intent for it to be a full social media app (chat functionality, posting content, etc.)**

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Wallet View: collection view of coins, My portfolio, value of account, description of coin
* Feed View: table view of coins, value of coins
* Settings View: UI view of team credits

**Optional Nice-to-have Stories**

* Coin Info: indepth info on selected coins
* NFT Art Gallery
* My Wallet/Portfolio: user "buys" and "sells" coins. The value of each and the total is displayed and tracked.
* Crypto News: A small section of the feed will have a scrolling/refreshing line of text containing crypto news
* Notifications: A notification appears when a price changes by a certain threshold

### 2. Screen Archetypes

* Login
   * User Sign in
   * User Sign up
* Wallet View
   * Collection view of crypto currencies
   * Portfolio view value of the account, description of coin
* Feed View
   * coin image
   * current market value of coin
* Settings View
   * Team Logo (Dyyper)
   * Team credits (names of the members)

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* [Wallet View]
* [Feed View]
* [Settings View]

**Flow Navigation** (Screen to Screen)

* [User Login -> Wallet View]
    * [Wallet View Cell  -> My Portfolio]
* [Settings -> Team credits]

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="https://i.imgur.com/GpRgfVR.jpg" width=600>

### [BONUS] Digital Wireframes & Mockups
Figma Wireframe: https://www.figma.com/file/fUa2beX6Y2vNY50vHFtWAr/DYYP?node-id=0%3A1


### [BONUS] Interactive Prototype

## Schema 

### Models

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user post (default field) |
   | author        | Pointer to User| image author |
   | image         | File     | image that user posts |
   | caption       | String   | image caption by author |
   | commentsCount | Number   | number of comments that has been posted to an image |
   | likesCount    | Number   | number of likes for the post |
   | createdAt     | DateTime | date when post is created (default field) |
   | updatedAt     | DateTime | date when post is last updated (default field) |
   
### Networking
#### List of network requests by screen
   - Login Screen
      - (Create/Post) Create a new user for the app
         ```swift
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
                
        user.signUpInBackground { (success, error) in
            if error != nil {
                        self.performSegue(withIdentifier: "loginViewSegue", sender: nil)
            }
            else {
                print("Error: \(error?.localizedDescription)")
            }
        }
         ```
      - (READ/Get) User can login to app
       ```swift
        let username = usernameField.text!
        let password = passwordField.text!
                
        PFUser.logInWithUsername(inBackground: username, password: password)
        {   (user, error) in
            if user != nil {
                        self.performSegue(withIdentifier: "loginViewSegue", sender: nil)
            }
            else {
                print("Error: \(error?.localizedDescription)")
            }
        }

#### [OPTIONAL:] Existing API Endpoints

##### coinapi.io - cryptocurrency information
- Base URL - https://rest.coinapi.io/

   HTTP Verb | Endpoint | Description
   ----------|----------|------------
    `GET`    | /v1/exchangerate/BTC | Gets the exchange rate for Bitcoin
    `GET`    | /v1/assets | Get detailed list of assets.
    `GET`    | /v1/assets/{asset_id} | Get detailS of specified asset.
    `GET`    | /v1/assets?filter_asset_id={filter_asset_id} | Get details about a list of assets.
    `GET`    | /v1/assets/icons/{iconSize} | Gets the list of icons (of the given size) for all the assets.
    


        
