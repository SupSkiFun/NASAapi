require "http"

class NasaFun
    def self.getAverage(obj)
        avg = ( ( obj['estimated_diameter_min'] + obj['estimated_diameter_max'] ) / 2 )
        return avg.round(5)
    end
end

def makeDate
    hoy = Time.now().to_s.split()[0]
end

def setConfig
    apj = "application/json"
    key = ENV['NASA_API_KEY']  # for using key from environment.
    #key = 'HARD_CODED_KEY_HERE'  if not using environment (line above)
    $url = 'https://api.nasa.gov/neo/rest/v1/feed'
    $hoy = makeDate()
    $msg = "Terminating.  Problem Accessing "+$url+" the below URL for asteroid information:\n"
    $heads = {
        "Content-Type" => apj ,
        "Accept" => apj
    }
    $params = {
        "api_key" => key ,
        "start_date" => $hoy ,
        "end_date" => $hoy
    }
end

def getInfo
    begin
        res = HTTP.get($url, :headers => $heads, :params => $params)
        if not res.status.success?
            raise res
        end
    rescue Exception => err
        puts($msg,err)
        exit
    end
    puts(res)
end


# def getInfo():
#     '''Retrieve Asteroid Information from NASA'''
#     try:
#         res = requests.get(url, headers=heads, params=params)
#         res.raise_for_status()
#     except requests.exceptions.HTTPError as err:
#         print(msg + str(err))
#         quit()
#     else:
#         jrd = res.json()
#         return jrd['near_earth_objects'][hoy]





setConfig()
getInfo()

#  Basic Testing "Stuff" Below

# testobj = {
#     'estimated_diameter_min' => 8.76543 ,
#     'estimated_diameter_max' => 9.67834
# }

# y=NasaFun.getAverage(testobj)
# puts($url,$hoy,$msg,$heads,$params,$y)



