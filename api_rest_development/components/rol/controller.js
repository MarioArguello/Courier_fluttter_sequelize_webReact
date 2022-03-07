const path = require('path')
const db = require(path.resolve(__dirname, '../../db.config'))
const Rol = db.rol


//ingresar datos a la tabla
exports.create = (req, res) => {
    Rol.create({
        nombre: req.body.nombre,
        estado: req.body.estado,
        utc: req.body.utc,
    }).then(rol => {
        res.json(rol)

    }).catch(err => {
        res.status(500).json({ msg: "error", mensaje: err });
        console.log('mensaje controlado', err)
    });
};

//consultar datos por el id
exports.filter = (req, res) => {
    const id = req.params.idrol
    var filter = {}
    if (req.params.idrol > 0) {
        filter = {
            where: {
                idrol: id
            }
        }
    }
    Rol.findAll(filter).then(rol => {
        res.json(rol);
    }).catch(err => {
        console.log(err);
        res.status(500).json({
            msg: "error", details: err
        });
    });
}

// Consultar todos los datos de la tabla 
exports.findAll = (req, res) => {
    Rol.findAll()
        .then(rol => {
            res.send(rol);
        }).catch(err => {
            res.status(500).send({
                message: err.message || "Some error occurred while retrieving data."
            });
        });
};

//Actualizar todos los datos de la tabla
exports.update = (req, res) => {
    Rol.update({
        nombre: req.body.nombre,
        estado: req.body.estado,
        utc: req.body.utc,
    },
        {
            where: {
                idrol: req.params.idrol,
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
    const id = req.params.idrol;
    Rol.destroy({
        where: {
             idrol: id 
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
