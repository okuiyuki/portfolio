FactoryBot.define do
    factory :post do
        title { "testtitle" }
        discription { "testdiscription" }
        github_url { "example.com" }
        app_url { "example.com" }
    end
end