ey-passenger-tweaks
===================
This cookbook is an example that can be used to change the passenger worker count and
reconfigure passenger_monitor. In this case, we are reducing the worker count and
increasing the memory limit on passenger_monitor so that an app that has high memory
requirements can run without being killed for bloating.

Installation
============
* Clone this repo, then copy this directory into your custom cookbooks directory.
* Change the variables at the top of recipes/default.rb to match your app, desired
worker count and memory limits
* Then edit your custom cookbook main/recipes/default.rb and add
    require_recipe "ey-passenger-tweaks"

Caveats
=======
* The syntax in this recipe is set to work with our cookbooks version >=1.1.116
if you are running any older version of the main cookbooks, then the memory_limit
variable in the recipe needs to be provided in bytes, not MB
* This recipe is only made to work with a single app, as it's more of a proof of
concept. It should be tweaked to loop through each app when creating the cron tasks
* You will restart Nginx twice on every Chef run with this recipe. If that is a problem
then you will need to investigate keep-filing nginx.conf and loading up a custom stack
config (maybe custom-stack.conf, rather than stack.conf)