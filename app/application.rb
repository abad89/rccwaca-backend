class Application

  def call(env)
    res = Rack::Response.new
    req = Rack::Request.new(env)



    if req.path.match(/test/) 
      return [200, { 'Content-Type' => 'application/json' }, [ {:message => "test response!"}.to_json ]]

    #cars index
    elsif req.path == '/cars' && req.get?
      cars = Car.all
      return [
        200,
        {'Content-Type' => 'application/json'},
        [ cars.to_json ]
      ]

    #cars show
    elsif req.path.match(/cars/) && req.get?
      car_id = req.path.split('/')[2]
      return [201, {'Content-Type' => 'application/json'}, [Car.find_by(id: car_id).to_json]]
   
    #cars create
    elsif req.path.match(/cars/) && req.post?
      body = JSON.parse(req.body.read)
      car = Car.create(body)
      return [201, {'Content-Type' => 'application/json'}, [car.to_json]]

    #cars update
    elsif req.path.match(/cars/) && req.patch?
      car_id = req.path.split('/')[2]
      body = JSON.parse(req.body.read)
      car = Car.find_by(id: car_id)
      car.update(body)
      return [202, {'Content-Type' => 'application/json'}, [car.to_json]]


    #cars delete
    elsif req.path.match(/cars/) && req.delete?
      car_id = req.path.split('/')[2]
      car = Car.find_by(id: car_id)
      car.destroy
      return [200, {'Content-Type' => 'application/json'}, [ {:message => "Car deleted"}.to_json]]





    #users index
    elsif req.path.match(/users/) && req.get?
      users = User.all
      return [
        200,
        {'Content-Type' => 'application/json'},
        [ users.to_json ]
      ]


    #users create
    elsif req.path.match(/users/) && req.post?
      body = JSON.parse(req.body.read)
      user = User.create_with_collection(body)
      return [201, {'Content-Type' => 'application/json'}, [user.to_json]]


    #user.add_car
    #TODO



    #collections show
    elsif req.path.match(/collection/) && req.get?
      user_id = req.path.split('/')[2]
      collection = Collection.find_by(user_id: user_id)
      if collection
        return [200, 
        { 'Content-Type' => 'application/json' }, 
        [ collection.cars.to_json ]
      ]
      else 
        return [
          404,
          { 'Content-Type' => 'application/json' }, 
          [ { error: 'user not found' }.to_json ]
        ]
      end

    else
      res.write "Path Not Found"

    end

    res.finish
  end

end
