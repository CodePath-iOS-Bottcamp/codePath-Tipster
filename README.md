# Pre-work - *Tipster*

**Tipster** is a tip calculator application for iOS.

Submitted by: **Arthur Burgin Jr**

Time spent: **10** hours spent in total

## User Stories

The following **required** functionality is complete:

* [X] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [X] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [ ] UI animations
* [X] Remembering the bill amount across app restarts (if <10mins)
* [X] Using locale-specific currency and currency thousands separators.
* [X] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

* [X] UI Re-design
* [X] Adding or subtracting the number of patrons to split the tip and total bill.
* [ ] Additional Themes(colors) for the app

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/FBpgnbc.gif' title='Video Walkthrough' width='' alt='' />
<img src='http://i.imgur.com/PtiyLfX.gif' title='Video Walkthrough2' width='' alt='' />


GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

* Designing the UI for the settings screen. Design isn't my strong suit so that took me more time to conceptualize what elements I wanted, where to place them and how the user would expect the interaction to be.
* Understanding how to use NSDate was tricky at first. I needed to understand what a NSDate object was and what it could do before figuring out how to get a time interval.
* I need to start commiting smaller changes instead of waiting to completely finish a feature/ui design change. 
* I noticed that my github history doesn't paint a pretty picture of my various updates. I want to get into the habit of squashing or rebasing commits during merges.
* I found a simple bug that was around since the persistance functionality was coded. I had to trace back through the entire functionality of the app to catch that it was a mistake in logic. I didn't account for that edge case scenario in the beginning. I definitely see how adding unit tests would be beneficial even if this is a "personal project".

## License

    Copyright [2017] [Arthur Burgin Jr]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
