class PagesController < ApplicationController
  %w(home about acknowledgements sign_up_selection).each do |a|
    define_method a do
    end
  end
end
