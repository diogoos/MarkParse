# MarkParse
A light expandable framework for Markdown parsing.
Made for [QuickNote](https://github.com/daemonleaf/QuickNote)

## Installing
1. Clone the repository: `$ git clone https://github.com/daemonleaf/MarkParse.git`
2. Open in Xcode and build for release
3. Add the resulting `MarkParse.framework` file to your project.
4. Under the project target, make sure that the framework is added to the *Frameworks, Libraries and Embedded Content* list, and that the Embed and Sign option is selected.
5. Use in your project with `import MarkParse`

## Documentation
The full documentation can be downloaded using [jazzy](https://github.com/realm/jazzy).
Simply download jazzy with `[sudo] gem install jazzy`, then run jazzy into the root directory you cloned. This will
generate the full documentation, which you can view by opening the `./docs/index.html` file in any web browser.

> The documentation can also alternatively be viewed without Jazzy by Option+Clicking in any class name imported from MarkParse inside Xcode.

## License

Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
