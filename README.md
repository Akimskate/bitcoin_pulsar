# Bitcoin Pulsar

### Cryptocurrency tracker.

In this app data provided by CoinGecko open API.

When starting app you can see spash screen


<p float="left">
<img  width="150" height="300" src="screenshots/splash_screen.png">
</p>

Then opens main screen with listview builder, where you can see first 20 tokens sorted by market capitilazition, with most userful information.
In this app implemented changind light and dark themes, and pagination - when scroll down to last last coin - downloading next 20 coins.


<img  width="150" height="300" src="screenshots/main_page_dark.png">
<img  width="150" height="300" src="screenshots/main_page_light.png">


You can update information by pulldown action:

<img  width="150" height="300" src="screenshots/main_page_pull_refresh.png">


For more information and history price since last year - click on token. You can see chart (builded with **fl_chart**), and short description of coin, with deeplinks (used **url_launcher** and **flutter_likify**).

<p float="left">
<img align="left" width="150" height="300" src="screenshots/chart_dark.png">
<img align="left" width="150" height="300" src="screenshots/chart_light.png">
<img align="center" width="150" height="300" src="screenshots/deeplonk_route.png">
</p>

