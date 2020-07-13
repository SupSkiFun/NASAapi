class NasaFun
    def self.first_method(x,y)
        return (x + y).round(2)
    end
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

setConfig()

#  Basic Testing "Stuff" Below

x = NasaFun.first_method(3.4562783,2.3899273)
puts(x)

testobj = {
    'estimated_diameter_min' => 8.76543 ,
    'estimated_diameter_max' => 9.67834
}

y=NasaFun.getAverage(testobj)
puts(y)



