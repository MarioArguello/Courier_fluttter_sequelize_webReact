const path = require('path')
const db = require(path.resolve(__dirname, '../../db.config'))
const Usuario = db.usuario


//ingresar datos a la tabla
exports.create = (req, res) => {
    Usuario.create({
        idpersona: req.body.idpersona,
        idrol: req.body.idrol,
        username: req.body.username,
        password: req.body.password,
        estado: req.body.estado,
        utc: req.body.utc, 
    }).then(usuario => {
        res.json(usuario)
    }).catch(err => {
        res.status(500).json({ msg: "error", mensaje: err });
        console.log('mensaje controlado', err)
    });
};

//consultar datos por el id
exports.filter = (req, res) => {
    const id = req.params.idusuario
    var filter = {}
    if (req.params.idusuario > 0) {
        filter = {
            where: {
                idusuario: id
            }
        }
    }
    Usuario.findAll(filter).then(usuario => {
        res.json(usuario);
    }).catch(err => {
        console.log(err);
        res.status(500).json({
            msg: "error", details: err
        });
    });
}

// Consultar todos los datos de la tabla 
exports.findAll = (req, res) => {
    Usuario.findAll()
        .then(usuario => {
            res.send(usuario);
        }).catch(err => {
            res.status(500).send({
                message: err.message || "Some error occurred while retrieving data."
            });
        });
};

//Actualizar todos los datos de la tabla
exports.update = (req, res) => {
    Usuario.update({
        idpersona: req.body.idpersona,
        idrol: req.body.idpersona,
        username: req.body.username,
        password: req.body.password,
        estado: req.body.estado,
        utc: req.body.utc,  
    },
        {
            where: {
                idusuario: req.params.idusuario,
            }
        })
        .then(() => {
            res.status(200).json(req.body);
        }).catch(err => {
            console.log(err);
            res.status(500).json({
                msg: "error", details: err
            });
        });
};


//Eliminar un registro de la tabla por id
exports.delete = (req, res) => {
    const id = req.params.idusuario;
    Usuario.destroy({
        where: {
             idusuario: id 
            },
    }).then(() => {
        res.status(200).json({
             msg: 'Registro eliminado -> Representante cedula = ' + id 
            });
    }).catch(err => {
        console.log(err);
        res.status(500).json(
            { 
                msg: "error", details: err
        });
    });
};
