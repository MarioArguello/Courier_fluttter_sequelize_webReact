const config = {
    port: process.env.PORT || 3000,
    host: process.env.HOST || 'http://localhost',
    publicRoute: process.env.PUBLIC_ROUTE || '/',
    filesRoute: process.env.FILES_ROUTE || 'files'
}

module.exports = config