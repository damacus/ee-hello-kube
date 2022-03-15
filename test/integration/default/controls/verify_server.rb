control 'Server Responds' do
  impact 1
  title 'The Web server should be reachable'
  desc 'The webserver should be reachable via HTTP'

  describe http('http://localhost:8080/') do
    its('status') { should cmp 200 }
    its('body') { should match /Hello World/ }
  end

end
