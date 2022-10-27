Original App Design Project - README Template
===

# DYYP

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
DYYP is a cryptocurrency focused app: it monitors the crpyto market for prices, trade volume, and important news. Users can personalize their feed, a profile, and a simulated crypto wallet. The user can also seen in-depth information about a specific coin in a seperate view.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category: Finance News**
- **Mobile: iOS, modern**
- **Story: A user can browse the app to monitor crypto markets and news, as well as their own holdings.**
- **Market: 21-40 year olds interested in finance**
- **Habit: To monitor their holdings and prices, Users would browse the app daily when the market is slow and every few minutes when there are rapid changes.**
- **Scope: More personal and focused, there is no intent for it to be a full social media app (chat functionality, posting content, etc.)**

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User Login (persistant without logging out)
* Cryto Feed: prices and trade volume
* Settings/Profile: favorite coins, aesthetic settings

**Optional Nice-to-have Stories**

* Coin Info: indepth info on selected coins
* NFT Art Gallery
* My Wallet/Portfolio: user "buys" and "sells" coins. The value of each and the total is displayed and tracked.
* Crypto News: A small section of the feed will have a scrolling/refreshing line of text containing crypto news
* Notifications: A notification appears when a price changes by a certain threshold

### 2. Screen Archetypes

* Login
   * create a persistent account
   * access existing account
* Crypto Feed
   * scroll through coin prices
   * select coin cell, get more info
* Settings/Profile
   * aesthetic settings (darkmode)
   * favorite coins
   * notification settings
* Coin Info
   * prices
   * image
   * news
   * trends
* Wallet/Portfolio
   * buy and sell
   * value of your portfolio
   * history

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* [Main Feed]
* [Settings]
* [Wallet View]

**Flow Navigation** (Screen to Screen)

* [Forced Login -> Main Feed]
* [Main Feed Cell -> Coin Info]
* [Settings -> favorites]

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="YOUR_WIREFRAME_IMAGE_URL" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
