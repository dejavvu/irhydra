// Copyright 2014 Google Inc. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

library graph_pane;

import 'package:irhydra/src/ui/graph.dart' as graphview;
import 'package:polymer/polymer.dart';

/**
 * Two column WebComponent used to display IRs and native code line by line.
 *
 * Individual lines or whole ranges can have an identifier associated with them
 * that allows to access these lines content as HTML, apply styles or reference
 * them by an [AnchorElement].
 *
 * First column *gutter* is used to display identifier e.g. block name,
 * SSA name or instruction's offset.
 *
 * Second column is for line's content e.g. instruction body itself.
 */
@CustomTag('graph-pane')
class GraphPane extends PolymerElement {
  final applyAuthorStyles = true;

  @published var ir;

  GraphPane.created() : super.created();

  enteredView() {
    super.enteredView();
    render();
  }

  irChanged() {
    render();
  }

  var _renderedIr;

  render() {
    if (_renderedIr == ir) return;
    _renderedIr = ir;

    final stopwatch = new Stopwatch()..start();
    graphview.display($["graph"], ir.blocks, (x, y) => x);
    print("GraphPane.render() took ${stopwatch.elapsedMilliseconds}");
  }
}