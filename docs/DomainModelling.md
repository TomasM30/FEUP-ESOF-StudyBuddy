# Domain Modelling

<p align = "center">
  <img src = https://github.com/FEUP-LEIC-ES-2022-23/2LEIC05T3/blob/main/images/domain_model.drawio.png>
</p>

Each user will have:
 - A unique `id` value
 - A username `name`
 - An `email` and `password` associated with their account
 - An experience amount `userXpAmount` associated with their experience level `userXpLevel`
 - A `coin` balance

The `Settings` class is used by the user to toggle certain features of the app, like background music or the app's notifications.

Within the study mode screen, there will be a `Timer` that will run until the user tells it to stop.

The user will also have access to a `Shop` where they can buy various `Items` using coins from their coin balance.

Associated with the timer, there will be a `Streak` of days in a row in which the user has recorded a time of 30min or over using said timer.

And of course, the main feature of the app, the user will have a `Buddy` of a certain species, walking around the screen and featuring different animations depending on the species chosen. <br>
**NOTE:** A user can only have one buddy active at a certain point in time.

Finally, a `Log` will be kept of all previous study sessions on a calendar, so that the user can look back at their progress.
