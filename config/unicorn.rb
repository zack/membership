app_path = File.expand_path(File.dirname(__FILE__) + '/..')

working_directory app_path

pid app_path + '/tmp/unicorn.pid'

stderr_path app_path + '/log/unicorn.log'
stdout_path app_path + '/log/unicorn.log'


listen app_path + '/tmp/unicorn.sock', backlog: 64

worker_processes 1

timeout 30

preload_app true
