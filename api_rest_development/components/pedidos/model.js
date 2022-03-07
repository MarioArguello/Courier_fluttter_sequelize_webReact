module.exports = (sequelize, Sequelize)=> {
    const Pedidos = sequelize.define('pedidos',{
        idpedidos: {
            type: Sequelize.UUID,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true
        },
        idpersona: {
            type: Sequelize.INTEGER,
        },
        utc: {
            type: Sequelize.DATE,
        },
        shipper: {
            type: Sequelize.STRING,
        },
        consignee: {
            type: Sequelize.STRING,
        },
        carrier: {
            type: Sequelize.STRING,
        },
        tracking: {
            type: Sequelize.STRING,
        },
        valorcompra:{
            type: Sequelize.DOUBLE,
        },
        detallecompra: {
            type: Sequelize.STRING,
        },
        estado:{
            type: Sequelize.STRING,
        },foto:{
            type: Sequelize.STRING,
        }
    },
    { timestamps: false})
    return Pedidos
}