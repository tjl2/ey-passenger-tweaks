# Add your appname here
app_name = 'example'
# Add the new worker count you want
worker_count = 4
# Add the memory limit you want to pass
# to passenger_monitor in MB
memory_limit = 320

template "/etc/nginx/stack.conf" do
  owner node[:owner_name]
  group node[:owner_name]
  mode 0644
  source "stack.conf.erb"
  variables({:worker_count => worker_count})
end

cron "passenger_monitor_#{app_name}" do
  action :delete
end

cron "passenger_monitor_#{app_name}" do
  minute  '*'
  hour    '*'
  day     '*'
  month   '*'
  weekday '*'
  command "/usr/bin/lockrun --lockfile=/var/run/passenger_monitor_#{app_name}.lockrun -- /bin/bash -c '/engineyard/bin/passenger_monitor #{app_name} -l #{memory_limit} >/dev/null 2>&1'"
end
