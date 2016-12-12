namespace :inject do
  desc "Inject initial data as per 13 December 2016"
  task initial: :environment do
    engineers_data = [
      {
        slack_username: "andrewjap",
        duty_date: nil,
        duty_fulfilled: true,
        duty_owed: false,
      },
      {
        slack_username: "ardhan",
        duty_date: nil,
        duty_fulfilled: false,
        duty_owed: false,
      },
      {
        slack_username: "bpj",
        duty_date: nil,
        duty_fulfilled: false,
        duty_owed: false,
      },
      {
        slack_username: "chrishadi",
        duty_date: nil,
        duty_fulfilled: false,
        duty_owed: false,
      },
      {
        slack_username: "enang.yusup",
        duty_date: nil,
        duty_fulfilled: false,
        duty_owed: false,
      },
      {
        slack_username: "erickaqua",
        duty_date: nil,
        duty_fulfilled: true,
        duty_owed: false,
      },
      {
        slack_username: "erikcarla",
        duty_date: nil,
        duty_fulfilled: true,
        duty_owed: false,
      },
      {
        slack_username: "junita",
        duty_date: nil,
        duty_fulfilled: true,
        duty_owed: false,
      },
      {
        slack_username: "karsanda",
        duty_date: nil,
        duty_fulfilled: true,
        duty_owed: false,
      },
      {
        slack_username: "kusut",
        duty_date: nil,
        duty_fulfilled: true,
        duty_owed: false,
      },
      {
        slack_username: "meir",
        duty_date: nil,
        duty_fulfilled: false,
        duty_owed: false,
      },
      {
        slack_username: "michimawan",
        duty_date: nil,
        duty_fulfilled: false,
        duty_owed: false,
      },
      {
        slack_username: "yohan",
        duty_date: nil,
        duty_fulfilled: false,
        duty_owed: false,
      },
    ]
    ATTRIBUTES = [:slack_username, :duty_date, :duty_fulfilled, :duty_owed]
    engineers_data.each do |engineer_data|
      engineer = Engineer.new
      ATTRIBUTES.each {|attribute| engineer.send("#{attribute}=", engineer_data[attribute])}
      engineer.save
    end
  end
end
