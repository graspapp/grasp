shared_examples "a forbidden action" do
  it "redirects to the referer or root path" do
    expect(response).to redirect_to(request.headers["Referer"] || root_path)
  end

  it "flashes a not authorized error" do
    expect(flash[:alert]).to match /not authorized/m
  end
end
