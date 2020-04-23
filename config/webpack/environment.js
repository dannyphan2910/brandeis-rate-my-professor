const { environment } = require("@rails/webpacker");
const webpack = require("webpack");

environment.plugins.append(
"Provide",

new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    'window.Tether': "tether",
    Popper: ["popper.js", "default"]
}),
);

environment.config.set('resolve.alias', aliasConfig);

module.exports = environment;