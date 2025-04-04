const express = require("express")
const fs = require("fs")
const path = require("path")

const app = express()
const PORT = process.env.PORT || 3000
const FILE_DIR = "/shared"

app.get('/api/files', (req, res) => {
    fs.readdir(FILE_DIR, (err, files) => {
        if(err){
            return res.status(500).json({error: 'Error al leer los archivos'})
        }
        res.json(files)
    })
}) 

app.get('/api/files/:filename', (req, res) => {
    const filePath = path.join(FILE_DIR, req.params.filename)
    if(fs.existsSync(filePath)){
        res.download(filePath)
    }else {
        res.status(404).json({error: 'Archivo no encontrado'})
    }
})

app.listen(PORT, () =>{
    console.log(`API DE DESCARGA ESCUCHANDO EN EL PUERTO ${PORT}`)
})