class RootController < ApplicationController
    def root
        render json: 'hello world'.to_json
    end
end
