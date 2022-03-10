class WelcomeController < ApplicationController
    # had to use this work around since I used the 'api only' option for rails app

    def index
        render file: Rails.root.join('public', 'index.html')
    end
end
