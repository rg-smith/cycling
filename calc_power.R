# calculate power to bike up a hill
# formulas from http://anonymous.coward.free.fr/wattage/cda/indirect-cda.pdf

calc_watts_gr=function(wt_kg,wt_bike_kg,time_s,elev_m){
  pwr=(wt_kg+wt_bike_kg)*9.8*elev_m/time_s
  return(pwr)
}

calc_watts_rr=function(gradient,weight,crr,distance,time){
  pwr=9.8*cos(atan(gradient))*weight*crr*distance/time
  return(pwr)
}

calc_watts_drag=function(rho_air,CdA,v,wind_speed=0){
  v_air=v+wind_speed
  pwr=.5*CdA*rho_air*v*v_air^2
  return(pwr)
}

calc_watts_total=function(CdA,crr,wt,bike_wt,time,distance,elev,wind_speed=0){
  # units are in lbs, feet (elev), miles (distance) and minutes
  wind_speed_m_s=(wind_speed*5280*12*2.54/100)/3600
  time_s=time*60
  wt_kg=wt*0.453592
  wt_bike_kg=bike_wt*0.453592
  time_s=time*60
  distance_m=distance*5280*12*2.54/100
  elev_m=elev*12*2.54/100
  pwr_elev=calc_watts_gr(wt_kg,wt_bike_kg,time_s,elev_m)
  pwr_rr=calc_watts_rr(elev_m/distance_m,(wt_kg+wt_bike_kg),crr,distance_m,time_s)
  pwr_drag=calc_watts_drag(1.225,CdA,distance_m/time_s,wind_speed_m_s)
  tot_pwr=pwr_elev+pwr_rr+pwr_drag
  print(paste('power from gravity',round(pwr_elev,1),'power from tire resistance',
              round(pwr_rr,1),'power from air drag',
              round(pwr_drag,1),'total power',round(tot_pwr,1)))
}

calc_speed=function(pwr,CdA,crr,wt,bike_wt,slope,wind_speed=0){
  mass=(wt+bike_wt)*.453592
  a=.5*CdA*1.225
  b=0
  c=crr*mass*9.8+slope*mass*9.8
  d=-1*pwr
  snd_trm=-1*d/(2*a)-sqrt((-1*d/(2*a))^2+(c/(3*a))^3)
  speed=(-1*d/(2*a)+sqrt((-1*d/(2*a))^2+(c/(3*a))^3))^(1/3)+
    sign(snd_trm)*abs(snd_trm)^(1/3)
  speed=speed*2.23694
  return(speed)
}

CdA=.35
Crr=.006
wt=175
bike_wt=23

# old la honda PR
calc_watts_total(CdA,Crr,wt,bike_wt,27,2.98,1255) # strava estimate: 226 W

# fairly easy effort on Lions Club
calc_watts_total(CdA,Crr,wt,bike_wt,5+5/60,1.31,115)

# fairly easy climb on winchester, biking against wind
calc_watts_total(CdA,Crr,wt,bike_wt,5+43/60,1.25,129,3)

# fairly easy climb on Lions Club, biking against wind
calc_watts_total(CdA,Crr,wt,bike_wt,4,1.07,57,4)

# experiment for how much time is saved by modifying various factors (i.e. pushing
# harder on a flat stretch vs hilly stretch, drops, tires, aero)
timesaved_hill=(6.8/calc_speed(200,CdA,crr,wt,bike_wt,.08)-6.8/calc_speed(220,CdA,crr,wt,bike_wt,.08))*60
timesaved_flat=(24/calc_speed(200,CdA,crr,wt,bike_wt,0)-24/calc_speed(220,CdA,crr,wt,bike_wt,0))*60
timesaved_drops=(10/calc_speed(200,0.4,crr,wt,bike_wt,0)-10/calc_speed(200,0.3,crr,wt,bike_wt,0))*60
timesaved_tires=(10/calc_speed(200,CdA,.006,wt,bike_wt,0)-10/calc_speed(200,CdA,.003,wt,bike_wt,0))*60
timesaved_aero=(10/calc_speed(200,0.3,crr,wt,bike_wt,0)-10/calc_speed(200,0.25,crr,wt,bike_wt,0))*60
