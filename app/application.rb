class Application

  def call(env)
    res = Rack::Response.new
    req = Rack::Request.new(env)



    if req.path.match(/test/) 
      return [200, { 'Content-Type' => 'application/json' }, [ {:message => "test response!"}.to_json ]]

    elsif req.path == '/cars' && req.get?
      cars = Car.all
      return [
        200,
        {'Content-Type' => 'application/json'},
        [ cars.to_json ]
      ]

    elsif req.path.match(/users/) && req.get?
      users = User.all
      return [
        200,
        {'Content-Type' => 'application/json'},
        [ users.to_json ]
      ]

    elsif req.path.match(/collection/) && req.get?
      user_id = req.path.split('/')[2]
      collection = Collection.find_by(id: user_id)
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
