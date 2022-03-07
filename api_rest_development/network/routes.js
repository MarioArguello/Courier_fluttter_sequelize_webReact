const { dirname } = require('path');
const path = require('path')

module.exports = function(app) {
    /* INVOCACION DE TODOS LOS CONTROLADORES */
   
    const Persona = require(path.resolve(__dirname, '../components/persona/controller.js'))
    const Pedidos = require(path.resolve(__dirname, '../components/pedidos/controller.js'))
    const Rol = require(path.resolve(__dirname, '../components/rol/controller.js'))
    const Usuario = require(path.resolve(__dirname, '../components/usuario/controller.js'))
    const Procesos = require(path.resolve(__dirname, '../components/procesos/controller.js'))
    
    
    
    /* CRUD PERSONAS */
    app.post('/persona/create', Persona.create)
    app.get('/persona/get/:idpersona', Persona.filter)
    app.get('/persona/getAll', Persona.findAll)
    app.put('/persona/update/:idpersona', Persona.update)
    app.delete('/persona/delete/:idpersona', Persona.delete)
    
    /* CRUD PEDIDOS */
    app.post('/pedidos/create', Pedidos.create)
    app.get('/pedidos/get/:idpedidos', Pedidos.filter)
    app.get('/pedidos/getAll', Pedidos.findAll)
    app.put('/pedidos/update/:idpedidos', Pedidos.update)
    app.delete('/pedidos/delete/:idpedidos', Pedidos.delete)  

    
    /* CRUD ROL */
    app.post('/rol/create', Rol.create)
    app.get('/rol/get/:idrol', Rol.filter)
    app.get('/rol/getAll', Rol.findAll)
    app.put('/rol/update/:idrol', Rol.update)
    app.delete('/rol/delete/:idrol', Rol.delete) 

    /* CRUD USUARIO */
    app.post('/usuario/create', Usuario.create)
    app.get('/usuario/get/:idusuario', Usuario.filter)
    app.get('/usuario/getAll', Usuario.findAll)
    app.put('/usuario/update/:idusuario', Usuario.update)
    app.delete('/usuario/delete/:idusuario', Usuario.delete)
    // RUTAS DE PROCESOS 
    app.post('/proceso/create', Procesos.create)
    app.get('/usuario/login/:username/:password', Procesos.filter)
    app.get('/usuario/registro/:dni', Procesos.filterRegistro)
    app.get('/proceso/pedidos/:idpersona',Procesos.consult)
    app.get('/Enviar/:idpersona',Procesos.consultEnviar)
    app.get('/Eliminar/:idpersona',Procesos.consultEliminar)
    app.get('/usuario/dataperfilpersona/:idpersona', Procesos.perfilUser)
    app.get('/proceso/webmaster',Procesos.consultwebadmin)
}
    