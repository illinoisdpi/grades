# Grades

Grades is a Canvas auto grading LTI Rails-based application that automates the grading of programming assignments in Canvas. Using LTI (Learning Tools Interoperability) integration, it leverages RSpec tests and the [grade_runner](https://github.com/DPI-WE/grade_runner) gem to run automated tests against student submissions and provide immediate, transparent feedback.

## Features

- **Automated Grading**: Runs RSpec tests to quickly and accurately grade student assignments.
- **Canvas Integration**: Easily integrates with Canvas via LTI, allowing instructors to create assignments that use the auto-grader.
- **Student Build Reports**: Students can view detailed build reports showing what tests passed or failed.
- **Code Linking**: Optionally link test files (using file path and line number) to the repository (set via project URL) so students can review the test code.
- **Extensible and Customizable**: Designed to be extended or customized as needed.

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/dpi-tta/grades.git
cd grades
```

### 2. Install Dependencies

```bash
bundle install
```

### 3. Setup the Database

```bash
rails db:create db:migrate db:seed
```

### 4. Start the Server

```bash
rails server
```

Visit http://localhost:3000 in your browser to see the landing page.

## Development: Testing LTI Integration Locally

When developing and testing LTI integration, Canvas (or any external system) must be able to reach your local server. You can achieve this by:

- Using GitHub Codespaces: If you're using Codespaces, use the provided public URL to test the LTI integration.
- Using Ngrok: Run a tunnel with ngrok to expose your local server on the internet:

```bash
ngrok http 3000
```

Ngrok will provide a public URL (e.g., https://abcd1234.ngrok.io). Use this URL when setting up external tool configurations in Canvas.

## Canvas Integration Instructions

To set up the auto grading tool with Canvas, follow these steps:

### Add External App Integration

In your Canvas Admin settings, add an external app integration pointing to:

`https://yourdomain.com/config.xml`

### Create an Assignment with External Tool

When creating an assignment in Canvas, select "External Tool" as the submission type and set the Launch URL to:

`https://yourdomain.com/launch`

### Set Your Project URL

In the assignment settings, specify the Project URL as your repository URL. This should point to the repo that contains your RSpec tests and the grade_runner gem configuration.

## How It Works

### Educator Workflow

- Configure the LTI integration in Canvas.
- Create assignments that launch the auto grader.
- Review student build reports and provide feedback based on the automated test results.

### Student Workflow

- Launch the assignment via Canvas.
- View a detailed build report with a list of failing tests.
- Optionally, click links (constructed from file paths, line numbers, and the project repo URL) to review the corresponding test code.

## Testing

### Running RSpec Tests

We use RSpec for testing. To run all tests:

```bash
bundle exec rspec
```

To run specific test files:

```bash
bundle exec rspec spec/models/resource_spec.rb
```

### Swagger Documentation

The API is documented using Swagger through rswag. Tests in the `spec/requests` directory are used to generate Swagger documentation.

To generate Swagger documentation:

```bash
bundle exec rake rswag:specs:swaggerize
```

The documentation will be generated in `swagger/v1/swagger.yaml`.

To view the Swagger documentation, start the Rails server and visit:

<http://localhost:3000/api-docs>

## Contributing

Contributions are welcome! To contribute:

- Create a feature branch (`<issue-number>-<initials>-<feature-title>`).
- Commit your changes.
- Add specs for new features.
- Ensure all tests pass with `bundle exec rspec`.
- Generate updated Swagger docs with `bundle exec rake rswag:specs:swaggerize`.
- Open a pull request.

## License

This project is licensed under the MIT License.

## Contact

For questions or feedback, please open an issue on GitHub.
