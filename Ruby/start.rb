require "http"
require "json"

class NasaFun
    def self.getAverage(obj)
        avg = ( ( obj['estimated_diameter_min'] + obj['estimated_diameter_max'] ) / 2 )
        return avg.round(5)
    end

    def self.makeObj(obj)
        cad = obj['close_approach_data'][0]
        lo = {
            "Name" => obj['name'] ,
            "ID" => obj['id'] ,
            "PotentiallyHazardous" => obj['is_potentially_hazardous_asteroid'] ,
            "CloseApproachDateTime" => cad['close_approach_date_full'] ,
            "MissDistanceInKM" => round(float(cad['miss_distance']['kilometers']) , 5 ) ,
            "AbsoluteMagnitudeH" => obj['absolute_magnitude_h'] ,
            "DiameterInMeters" => NasaFun.getAverage(obj['estimated_diameter']['meters']) ,
            "VelocityInKMpH" => round(float(cad['relative_velocity']['kilometers_per_hour']) , 5 ) ,
            "URL" => obj['nasa_jpl_url']
        }
        return lo
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
    jrd = JSON.parse(res)
    return jrd['near_earth_objects'][$hoy]
end

# def procInfo(resp)
#     '''Process returned Asteroid information'''
#     arr = [
#         NasaFun.makeObj(r)
#         for r in resp
#     ]
#     lo = json.dumps(arr)
#     print(lo)
# end

setConfig()
tt = getInfo()
puts(tt)

#  Basic Testing "Stuff" Below

# testobj = {
#     'estimated_diameter_min' => 8.76543 ,
#     'estimated_diameter_max' => 9.67834
# }

# y=NasaFun.getAverage(testobj)
# puts($url,$hoy,$msg,$heads,$params,$y)



