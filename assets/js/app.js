// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import Prism from "prismjs"
import 'bootstrap';
import Sortable from 'sortablejs';
import css from "../css/app.scss"


let items = document.getElementById('items');
if(items) {
  var sortable = Sortable.create(items, {
    group: "localStorage-example",
    store: {
      /**
       * Get the order of elements. Called once during initialization.
       * @param   {Sortable}  sortable
       * @returns {Array}
       */
      get: function (sortable) {
        var order = localStorage.getItem(sortable.options.group.name);
        return [];
      },

      /**
       * Save the order of elements. Called onEnd (when the item is dropped).
       * @param {Sortable}  sortable
       */
      set: function (sortable) {
        var order = sortable.toArray();
        var data = new FormData();
        data.append('order', order);
        var xhttp = new XMLHttpRequest();
        let csrfToken = document.querySelector('meta[name="csrf-token"]').content;
        xhttp.open("POST", "/posts/save_posts_order", true);
        xhttp.setRequestHeader('x-csrf-token', csrfToken);
        xhttp.send(data);
        //localStorage.setItem(sortable.options.group.name, order.join('|'));
      }
    }
  });
}
// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
