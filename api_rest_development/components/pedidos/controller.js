const path = require('path')
const db = require(path.resolve(__dirname, '../../db.config'))
const pedidos = db.pedidos


//ingresar datos a la tabla
exports.create = (req, res) => {
    pedidos.create({
        idpersona: req.body.idpersona,
        shipper: req.body.shipper,
        consignee: req.body.consignee,
        carrier: req.body.carrier,
        tracking: req.body.tracking,
        valorcompra: req.body.valorcompra,
        detallecompra: req.body.detallecompra,
        estado: req.body.estado,
        foto: req.body.foto
    }).then(pedidos => {
        res.json(pedidos)

    }).catch(err => {
        res.status(500).json({ msg: "error", mensaje: err });
        console.log('mensaje controlado', err)
    });
};

//consultar datos por el id
exports.filter = (req, res) => {
    const id = req.params.idpedidos
    var filter = {}
    if (req.params.idpedidos > 0) {
        filter = {
            where: {
                idpedidos: id
            }
        }
    }
    pedidos.findAll(filter).then(pedidos => {
        res.json(pedidos);
    }).catch(err => {
        console.log(err);
        res.status(500).json({
            msg: "error", details: err
        });
    });
}

// Consultar todos los datos de la tabla 
exports.findAll = (req, res) => {
    pedidos.findAll()
        .then(pedidos => {
            res.send(pedidos);
        }).catch(err => {
            res.status(500).send({
                message: err.message || "Some error occurred while retrieving data."
            });
        });
};

//Actualizar todos los datos de la tabla
exports.update = (req, res) => {
    pedidos.update({
        idpersona: req.body.idpersona,
        shipper: req.body.shipper,
        consignee: req.body.consignee,
        carrier: req.body.carrier,
        tracking: req.body.tracking,
        valorcompra: req.body.valorcompra,
        detallecompra: req.body.detallecompra,
        estado: req.body.estado,
        foto: req.body.foto
    },
        {
            where: {
                idpedidos: req.params.idpedidos,
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
    const id = req.params.idpedidos;
    pedidos.destroy({
        where: { idpedidos  : id },
    }).then(() => {
        res.status(200).json({ msg: 'Registro eliminado -> Representante cedula = ' + id });
    }).catch(err => {
        console.log(err);
        res.status(500).json({ msg: "error", details: err });
    });
};
