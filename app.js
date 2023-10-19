const express = require('express');
const app = express();
const {Client} = require('pg')
const DAOusuario = require('./DAO/DAOusuario')

const client = new Client ({
    host:"bqnze3lsktl7tehwubei-postgresql.services.clever-cloud.com",
    user:"umqcsr9mkmjeb8mqysqs",
    password:"buGaOwptsN1AOfdrb1Um",
    port:"5432",
    database:"bqnze3lsktl7tehwubei"

});

client.connect();
// client.query(`SELECT * FROM public.usuario`, (err,res)=>{
//     var obj = [];
//     if (!err) {
//         // obj = res.rows;
//         // obj.forEach(element => {
//         //     console.log("nombre "+element.nombre+" apellido "+element.apellidos+" tiene password: "+element.contrasena+" y mail: "+element.mail);
//         // });
//         console.log(res.rows)
//     }
//     else {
//         console.log(err.message);
//     }
//     // client.end();
// });     

const dao = new DAOusuario(client);

// async function obtenerTodos() {
//   try {
//       const resultado = await dao.obtenerTodos();
//       if (resultado) {
//           return resultado
//       } else {
//           console.log('No se encontró ningún usuario con ese ID.');
//           console.log(err.me);
//       }
//   } catch (error) {
//       console.error('Ocurrió un error:', error);
//   }
// }

// dao.obtenerTodos()
//   .then((resultadoObtenido) => {
//     console.log(resultadoObtenido); // Imprime el resultado cuando la promesa se resuelve
//   })
//   .catch((error) => {
//     console.error(error); // Manejo de errores
//   });


// app.get('/', (req,res) => {

//     res.end('hola mundo');
// });

app.use(express.static(__dirname +'/public'));


app.listen(3000, () => {
    console.log('servidor iniciado...');
});


app.get('/consulta1', (req, res) => {
    // Aquí ejecutas la consulta SQL a la base de datos y obtienes los resultados.
    client.query(`SELECT * FROM public.usuario`, (error, result) => {
      if (error) {  // Si hay un error, se lanza una excepción.
        throw error;
      }
      // Envía los resultados como respuesta al cliente en formato JSON.
    //   res.send(result.rows);
      res.json(result.rows);
    });
  });


  app.get('/endpoint', (req, res) => {
    const data = req.query.data; // Aquí obtendrás el string enviado
  
    console.log('Recibido:'+data);

    dao.obtenerPorNombre(data)
    .then((resultadoObtenido) => {
      res.json(resultadoObtenido);
    })
    .catch((error) => {
      console.error(error); // Manejo de errores
    });
    
  });