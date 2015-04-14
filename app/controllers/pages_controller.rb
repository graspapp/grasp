class PagesController < ApplicationController
  %w(home about acknowledgements sign_up_selection).each do |a|
    define_method a do
    end
  end

  def tools
    @learning_tools = LearningTool.all
  end

  def show_pdf
    tool = LearningTool.find(params[:id])
    # send_file(tool.generate_filepath, type: 'application/pdf', disposition: 'inline')
    send_file tool.generate_filepath, type: 'application/pdf', disposition: 'inline'
  end
end
