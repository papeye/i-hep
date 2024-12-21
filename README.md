# IHEP

**IHEP** is a Flutter-based cross-platform app (macOS, iOS, web) that integrates with the [INSPIRE REST API](https://github.com/inspirehep/rest-api-doc). It provides an intuitive interface for exploring research data in high-energy physics.

## Features

### Dashboard Tab
- **Overview Metrics**: Total papers, authors, institutions, and conferences available in the API.
- **Top 10 Most Cited Papers**: A quick view of influential research.
- Tap any paper to view its **details**, including authors and abstract.

### Most Cited Papers Tab
- A paginated list of the most cited papers.
- Tap any paper to view its **details**, including authors and abstract.

## Dependencies

This project uses the following libraries:

- [bloc](https://pub.dev/packages/bloc) - For data-related state management.
- [http](https://pub.dev/packages/http) - For making HTTP requests.
- [flutter_hooks](https://pub.dev/packages/flutter_hooks) - for widgets state managment.
- [go_router](https://pub.dev/packages/go_router) - For declarative routing and navigation.

For the complete list of dependencies, refer to the [`pubspec.yaml`](pubspec.yaml) file.
