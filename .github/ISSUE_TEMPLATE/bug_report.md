---
name: Bug report
about: Create a report to help us improve
title: "[BUG]"
labels: 't2:  bug'
assignees: ''

---

### :warning: Before you start,
To help us help you figure out what went wrong, please take time to fill in the fields below. If we don't have enough information to be of assistance, then there's not much we can do other than close the issue – extra information helps in unexpected ways!

_Delete this top section in your issue report – many thanks!_

## Issue summary

### Short description & impact:

_e.g._
> **Description:**  Precision computation is off when comparing 2 view bounds.
> **Impact:**  False positives in tests about layout issues due to a `0.0001` margin.

### Steps to reproduce:

_e.g._
> 1. Create a view with ...
> 2. Create another view with ... , make sure that it is ... in relation to first view
> 3. Under unit tests, compare the two views via `sizesAreEquivalent...` API

### Expected outcome:

_e.g._
> Evaluate `true`  for views A & B to having equivalent sizes because ...

### Actual outcome:

_e.g._
> Views A & B evaluated `false` to having equivalent sizes ... error message reads ... `expected width 54.75003129 but got width 54.75004129`

### Self-contained code example that reproduces the issue:

_e.g._
```swift
// Consider attaching sample project, especially for things with intricate layoout details where a 'self-contained' code snippet is very hard to extract.

// ----- setup code -----
override func viewDidLoad() {
    super.viewDidLoad()
    viewA.translatesAutoresizingMaskIntoConstraints = false
    // ...
    // - best if code is directly runnable via copy-paste
    // - exercise best judgement on what details are needed
}

// ----- test code -----
it("should set the overlay size (view A) equal to content view (view B)") {
    expect(subject.viewA.isEqualSizeTo(subject.viewB))
        .to(beTrue())
}
```

### Reproducibility (based on code example supplied above)
  - [ ] deterministic, 100% repro
  - [ ] often, 50% - 100%
  - [ ] sometimes, 10% - 50%
  - [ ] hard, ~0% - 10%

## Other information

**`xcode` version:**
**Versions of `xcode` installed:**
**`UnIt` version:**

**Installation method**:
  - [ ] CocoaPods
  - [ ] Carthage
  - [ ] Git submodules

**Level of `UnIt`/testing knowledge**:
  - [ ] Fresh (just starting)
  - [ ] Novice (small code base or app)
  - [ ] Seasoned (complex code base or app)
