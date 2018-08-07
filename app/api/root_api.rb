class RootAPI < Grape::API
  rescue_from ActiveRecord::RecordNotFound, ->() { error!({error: 'Record not found'}, 404) }
  format :json
  prefix :api
  
  helpers ApiHelpers
  mount V1::Base
  add_swagger_documentation \
    info: {
      title: "JJEPR API",
      # description: "",
      # contact_name: "tao",
      # contact_email: "tao@tanmer.com",
    }
end