# Jobs Site

## Development

First run `bundle install`. Then the development server like this:

`$ foreman -f Procfile.dev`

We use `mailcatcher` to receive email on the development instance. You can check those mails here:

`http://localhost:1080/`

## TODO

- [ ] Design minimal splash page
- [ ] Make login emailing work
- [ ] Make possible to share with friends by email
- [ ] Make possible to share publicly via link
- [ ] Integrate GA to create a dashboard of traffic to the job listing
- [ ] Setup unicorn like https://github.com/maccman/trevi
- [ ] Implement tracking on invitation links