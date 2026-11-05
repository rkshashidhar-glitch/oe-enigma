# OpenEdge compilation and agent review

Load an OpenEdge ABL program in VS Code, compile it without running it, and
ask an agent to explain diagnostics and review your specified checks.
No ABL application is included yet: supply your program and its dependencies.

## Setup

1. Install a licensed, compiler-capable **OpenEdge 12.0 or later** runtime.
   The VS Code OpenEdge extension alone does not include the compiler.
   The driver uses `SESSION:EXIT-CODE`, which requires OpenEdge 12+.
2. Set `DLC` to the OpenEdge installation directory and launch VS Code from
   that environment (for example, from Proenv). Restart VS Code after changing
   environment variables. The tasks use `$DLC/bin/_progres` on Unix and
   `%DLC%\bin\_progres.exe` on Windows.
3. Open this repository as a VS Code folder. Add your `.p`, `.w`, or `.cls`
   source and required includes/classes. Save the file before compiling;
   compilation reads the file on disk, not unsaved editor changes.
4. Configure your project's `PROPATH` and any required database connections.
   For project-specific startup parameters, create a local
   `.vscode/openedge.pf` using your existing OpenEdge configuration. This file
   is ignored by Git; do not commit credentials or production connection details.
   Use development databases only. Keep this file limited to project startup
   parameters, not `-p` or `-param`, which the tasks supply.

## Compile and read diagnostics

With the source file active, run **Terminal → Run Build Task** (`Ctrl+Shift+B`)
to select **OpenEdge: compile active file**. For database schema or other
project startup requirements, use **Terminal → Run Task → OpenEdge: compile
active file with project parameters** and enter the parameter file path.

The task prints `filename:row:column: diagnostic` messages in the terminal,
followed by a compilation summary. Diagnostics are not mapped into VS Code's
Problems panel. The process exits with status `1` on compilation failure and
`0` on success; warnings may still be reported on success. OpenEdge startup
failures (such as licensing or database connection failures) occur before the
driver can print its summary.

The driver uses `COMPILE` without `SAVE`: it neither executes the selected
program nor writes its compiled `.r` file. Compile only trusted source:
preprocessor directives and startup/database configuration still require review.
An include (`.i`) must be checked by compiling a procedure that includes it.
Compile each relevant entry point; checking one file is not a project-wide test.

You or a local agent with terminal access can also invoke the driver directly:

```sh
"$DLC/bin/_progres" -b -p tools/compile.p -param "/absolute/path/to/program.p"
# If project parameters are required:
"$DLC/bin/_progres" -b -pf "/absolute/path/to/project.pf" -p tools/compile.p -param "/absolute/path/to/program.p"
```

Run these commands from the repository root. On Windows, use the executable
under `%DLC%\bin` with your shell's quoting conventions.

## Hand the review to an agent

Enable an agent-capable assistant in VS Code (for example, GitHub Copilot
Chat's Agent mode), select this workspace, and give it the source path and
the checks you want. The OpenEdge extension is not itself an autonomous
review agent. Review terminal permissions and proposed changes before approving.
For example:

> Review `src/program.p`. First inspect its includes and project configuration.
> Compile it using `tools/compile.p` and my local project parameter file.
> Do not execute the program, change database data, or expose credentials.
> Report compiler errors/warnings with file and line references. Check error
> handling, transaction scope, locking, and resource cleanup, plus these
> business rules: [provide rules and expected behavior].
> Explain each finding and suggest the smallest fix. Ask before editing.
> After approved changes, recompile and run only the tests I authorize.

Supply the OpenEdge version, source/entry points, include paths, required
development database schema, expected behavior, and custom checks. An agent
must report when it cannot access a licensed compiler rather than claim
compilation succeeded. A cloud agent does not inherit your local VS Code
installation; use a locally configured agent or provide sanitized diagnostics.

### Error-resolution guidelines

- **Compiler not found:** check `DLC`, the executable path, and the environment
  inherited by VS Code.
- **Missing include or class:** check `PROPATH`, relative paths, and filename
  case; compile from the same working directory as your project.
- **Unknown table or field:** connect the required development database/schema
  through your parameter file and check logical database names.
- **Syntax or type errors:** fix the first diagnostic first, then recompile;
  later errors may be consequences of the first one.
- **Successful compilation:** still review warnings, business rules, error
  handling, and transaction/locking behavior. Compilation is not a functional
  test or proof of correctness.

The repository has no automated ABL tests or bundled OpenEdge runtime.
Validate compilation and approved functional tests in your licensed development
environment before relying on results.

---

# Communicate using Markdown

_Organize ideas and collaborate using Markdown, a lightweight language for text formatting._

## Welcome

GitHub is about more than code. It's a platform for software collaboration, and Markdown is one of the most important ways developers can make their communication clear and organized in issues and pull requests. This course will walk you through creating and using headings more effectively, organizing thoughts in bulleted lists, and showing how much work you've completed with checklists. You can even use Markdown to add some depth to your work with the help of emojis, images, and links.

- **Who is this for**: New developers, new GitHub users, and students.
- **What you'll learn**: Use Markdown to add lists, images, and links in a comment or text file.
- **What you'll build**: We'll update a plain text file and add Markdown formatting, and you can use this file to start your own GitHub Pages site.
- **Prerequisites**: In this course you will work with pull requests as well as edit files. If these things aren't familiar to you, we recommend you take the [Introduction to GitHub](https://github.com/skills/introduction-to-github) course, first!
- **How long**: This course takes less than one hour to complete.

In this course, you will:

1. Add headers
2. Add an image
3. Add a code example
4. Make a task list
5. Merge your pull request

### How to start this course

Simply copy the exercise to your account, then give your favorite Octocat (Mona) **about 20 seconds** to prepare the first lesson, then **refresh the page**.

[![](https://img.shields.io/badge/Copy%20Exercise-%E2%86%92-1f883d?style=for-the-badge&logo=github&labelColor=197935)](https://github.com/new?template_owner=skills&template_name=communicate-using-markdown&owner=%40me&name=skills-communicate-using-markdown&description=Exercise%3A+Communicate+using+Markdown&visibility=public)

<details>
<summary>Having trouble? 🤷</summary><br/>

When copying the exercise, we recommend the following settings:

- For owner, choose your personal account or an organization to host the repository.
- We recommend creating a public repository, as private repositories will [use Actions minutes](https://docs.github.com/en/billing/managing-billing-for-github-actions/about-billing-for-github-actions).

If the exercise isn't ready in 20 seconds:

1. After your new repository is created, wait about 20 seconds, then refresh the page.
2. Follow the step-by-step instructions in the issue created in your repository.
3. If the page doesn't refresh automatically, please check the [Actions](../../actions) tab.
   - Check to see if a job is running. Sometimes it simply takes a bit longer.
   - If the page shows a failed job, please submit an issue. Nice, you found a bug! 🐛

</details>

---

&copy; 2026 GitHub &bull; [Code of Conduct](https://www.contributor-covenant.org/version/2/1/code_of_conduct/code_of_conduct.md) &bull; [MIT License](https://gh.io/mit)
