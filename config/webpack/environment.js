const webpack = require('webpack');
const { environment } = require('@rails/webpacker')

// environment.plugins.append('ProvidePlugin-jQuery', new webpack.ProvidePlugin({jQuery: 'jquery'}));

environment.plugins.prepend('Provide',
    new webpack.ProvidePlugin({
        $: 'jquery/src/jquery',
        jQuery: 'jquery/src/jquery',
        Popper: 'popper.js'
    })
)

module.exports = environment
