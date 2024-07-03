from django.shortcuts import render # type: ignore
from .models import City

filename = "worldcities.csv"
index = [0, 2, 3]

class CFMaps:
  
  def __init__(self):
    self.flag = True
  
  def getLatLong(self, cityname):
     dictLL = {}
     city1 = City.objects.get(cityname=cityname)
     dictLL['lat'] = city1.lat
     dictLL['lng'] = city1.long
     return dictLL
  
  def parse_csv(self):
    if (len(City.objects.all()) < 1):
        f = open("CFMaps/static/files/" + filename, 'r', encoding="utf8")
        line = f.readline()
        line = f.readline()
        cityname = ""
        lat = ""
        long = ""
        while line != "":
            lineSplit = line.split(',')
            cityname = lineSplit[index[0]]
            lat = lineSplit[index[1]]
            long = lineSplit[index[2]]
            uid = len(City.objects.all()) + 1
            q = City.objects.create(uid=uid, cityname=cityname, lat=lat, long=long)
            q.save()
            line = f.readline()
        f.close()
    else:
       pass
    return


def get_params(request, keys):
  params = {}
  for key in keys:
    params[key] = request.GET.get(key)
  return params


def check_empty(params, key):
  return ((params[key] == None) or (params[key] == ""))


def index(request):
  if request.method == "GET":
    cfmap1 = CFMaps()
    cfmap1.parse_csv()
    params = get_params(request, ['cityname', 'lat_range', 'alt'])
    context = {}
    latlng = {}
    if check_empty(params, 'cityname'):
        pass
    else:
        latlng = cfmap1.getLatLong(params['cityname'])
        context = {'cityname': params['cityname'], 'latlng':[latlng['lat'], latlng['lng']]}
    return render(request, 'CFMaps/index.html', context)
