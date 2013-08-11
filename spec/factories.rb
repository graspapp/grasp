FactoryGirl.define do
  factory :teacher do
    first_name                    'Factory'
    last_name                     'Teacher'
    email                         'factteach@sample.com'
    password                      'samplepassword'
    password_confirmation         'samplepassword'
    school                        'Sample School'
    city                          'LA'
    state                         'CA'
    country                       'USA'
  end

  factory :student do
    first_name                      'Factory'
    last_name                       'Student'
    email                           'factstud@sample.com'
    password                        'samplepassword'
    password_confirmation           'samplepassword'
    class_code                      '13dsja34'
  end
end