require 'xmlsimple'

def kill_processes
  xml =  `sudo passenger --show = xml`
  get_long_running_pids(xml).each do |pid| 
    `kill -9 #{pid}`
  end
  puts 'done'
end

def get_long_running_pids(xml)
  pids = []
  passenger_stats = XmlSimple.xml_in(xml)
  passenger_stats['supergroups'][0]['supergroup'][0]['group'][0]['processes'][0]['process'].each do |process|
    if get_last_used_from_now_in_minutes(process['last_used'][0].to_i) > 60
      pids << process['pid'][0]
    end
  end
  
  return pids
end

def get_last_used_from_now_in_minutes(last_used_number)
  (Time.now - Time.at(last_used_number / 1000000)) / 60
end

kill_processes()