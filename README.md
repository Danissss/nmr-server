# NMR Prediction Server

> ⚠️ **Project Status**: This project was originally developed ~7 years ago. It is currently being **updated and modernized** (April 2026). Some dependencies, documentation, and practices may be outdated. Please report any issues or compatibility problems.

A Rails-based web application for predicting ¹H NMR chemical shifts from molecular structures. Draw, upload, or input SMILES strings to get NMR spectrum predictions with interactive visualization.

## Features

- 📐 **Interactive Molecule Drawing** - Use MarvinJS to draw chemical structures
- 📄 **Multiple Input Methods** - SMILES strings, SDF/MOL files, or drawn structures
- 🧪 **Sample Molecules** - Pre-loaded test compounds (e.g., Adenosine)
- 📊 **NMR Spectrum Visualization** - Interactive graphs with peak picking
- 🔄 **Real-time Processing** - MATLAB-based NMR predictions

## Requirements

### System Requirements

- **macOS** (Intel or Apple Silicon)
- **Ruby** 3.3.3
- **Java** - For running JAR files (NMR prediction engine)
- **Python 3** - For MATLAB integration
- **MATLAB** (Intel Mac) - Latest version with MATLAB Engine for Python

### Software Dependencies

See `Gemfile` for Ruby gems. Key dependencies:
- Rails 7.1.0
- SQLite3
- Carrierwave (file uploads)
- Rest-client

## Installation

### 1. Clone Repository

```bash
cd /Users/xuan/Desktop/nmr-server
```

### 2. Install Ruby Gems

```bash
bundle install
```

### 3. Install MATLAB Engine for Python 3

**If you don't have MATLAB installed:**
1. Download and install [MATLAB for Mac (Intel)](https://www.mathworks.com/downloads/)
2. Run the installer and complete setup

**Install MATLAB Engine for Python 3:**

```bash
cd /Applications/MATLAB_R20XX.app/extern/engines/python
python3 setup.py install
```

Replace `R20XX` with your MATLAB version (e.g., `R2024b`)

**Verify installation:**

```bash
python3 -c "import matlab.engine; print('✅ MATLAB Engine OK')"
```

### 4. Create Database

```bash
rails db:create
rails db:migrate
```

### 5. Verify Java Installation

```bash
java -version
```

Should output Java version. If not found, install from [OpenJDK](https://openjdk.java.net/) or [Oracle Java](https://www.java.com/).

## Configuration

The application is configured to use:
- **Database**: SQLite3 (`db/development.sqlite3`)
- **Port**: Default Rails port (3000)
- **File Uploads**: `public/uploads/`
- **Temporary SDF Files**: `public/tmp_sdf/`

## Running the Application

### Start Development Server

```bash
rails server
```

Or with a specific port:

```bash
rails server -p 3000
```

Visit: `http://localhost:3000/query/new`

### Input Methods

1. **Draw Molecule** - Use the MarvinJS sketcher to draw your structure
2. **SMILES/File** - Enter SMILES string or upload SDF/MOL file
3. **Sample Test** - Run with pre-loaded Adenosine molecule

## File Structure

```
nmr-server/
├── app/
│   ├── controllers/query_controller.rb    # Main prediction logic
│   ├── models/input_model.rb              # Data model for inputs
│   ├── views/query/
│   │   ├── new.html.erb                   # Input interface
│   │   └── result.html.erb                # Results display
│   └── helpers/query_helper.rb
├── lib/module/
│   ├── run_nmr_pred.rb                    # NMR prediction module
│   ├── molecule_format.rb                 # SDF/SMILES conversion
│   └── get_sdf.rb                         # SDF file utilities
├── vendor/
│   ├── nmr_pred/nmr_pred.jar              # NMR prediction engine
│   ├── convert_to_smiles/                 # SMILES conversion tools
│   ├── cdk/                               # Chemistry Development Kit
│   ├── matlab/                            # MATLAB scripts
│   ├── callMatlab.py                      # Python-MATLAB bridge
│   └── test.py                            # Test utilities
├── public/
│   ├── marvin4js/                         # Molecular structure editor
│   ├── tmp_sdf/                           # Temporary SDF files
│   └── uploads/                           # User uploads
└── db/
    └── development.sqlite3                # SQLite database
```

## Usage Examples

### Example 1: Run Sample Test

1. Navigate to `http://localhost:3000/query/new`
2. Click "🧪 Run Sample Test" button
3. View results with Adenosine molecule and NMR spectrum

### Example 2: Draw and Predict

1. Use the MarvinJS sketcher to draw a molecule
2. Click "📐 Predict from Drawing"
3. Results will show structure and spectrum

### Example 3: SMILES Input

1. Enter a SMILES string: `CC(C)Cc1ccc(cc1)C(C)C(O)=O` (Ibuprofen)
2. Click "💡 Predict from SMILES/File"
3. View prediction results

## Dependencies & Integration

### Java JAR Files

- **nmr_pred.jar** - Predicts NMR chemical shifts (requires Chemistry Development Kit)
- **Convert_To_Smiles.jar** - Converts SDF structures to SMILES strings
- **cdk-2.1.1.jar** - Chemistry Development Kit library

### Python/MATLAB

- **callMatlab.py** - Bridges Python and MATLAB for spectrum calculation
- **MATLAB Engine** - Executes MATLAB scripts for signal processing

### JavaScript Libraries

- **MarvinJS** - Chemical structure editor (ChemAxon)
- **Chart.js** - NMR spectrum visualization
- **jQuery** - DOM manipulation

## Troubleshooting

### ⚠️ "MATLAB Engine not found"

**Solution:**
```bash
# Verify MATLAB Engine installation
python3 -c "import matlab.engine; print('OK')"

# If not found, reinstall:
cd /Applications/MATLAB_R20XX.app/extern/engines/python
python3 setup.py install
```

### ⚠️ "Java command not found"

**Solution:**
```bash
# Install Java
brew install openjdk@17

# Or download from https://www.java.com/
```

### ⚠️ "Python/MATLAB script failed"

The application will log warnings instead of crashing. Check Rails logs:
```bash
tail -f log/development.log
```

### ⚠️ NMR spectrum not displaying

Ensure MATLAB Engine is properly installed and all JAR files exist in `vendor/` directory.

## Testing

Run tests with:

```bash
rails test
```

Test files are in `test/` directory.

## Database

### Create Database

```bash
rails db:create
```

### Run Migrations

```bash
rails db:migrate
```

### View Schema

```bash
rails db:schema:dump
```

## Deployment

This application is configured for development. For production deployment:

1. Update `config/database.yml` for production database
2. Set environment variables (see `.env` example)
3. Precompile assets: `rails assets:precompile`
4. Use production Puma configuration in `config/puma.rb`
5. Deploy using Capistrano or your preferred method

## Environment Variables

Create `.env` file in project root:

```bash
# MATLAB Configuration
MATLAB_TIMEOUT=30

# Rails
RAILS_ENV=development
SECRET_KEY_BASE=your_secret_key_here
```

## License

This project uses:
- MarvinJS (ChemAxon) - Licensed software
- Chemistry Development Kit (CDK) - LGPL
- Rails, Ruby - Open source

See `public/marvin4js-license.cxl` for ChemAxon license details.

## Support & Resources

- **MarvinJS Docs**: https://www.chemaxon.com/marvin/
- **MATLAB Engine**: https://www.mathworks.com/help/matlab/matlab_external/
- **Rails Guides**: https://guides.rubyonrails.org/

## Version History

- **v1.0** - Initial release (~2018)
- **v2.0** (April 2026) - **Major Modernization Update**
  - Upgraded from JRuby to standard Ruby 3.3.3
  - Upgraded Rails 5.2 → 7.1.0
  - Replaced deprecated gems (Uglifier → Terser, Paperclip → commented out)
  - Updated JDBC adapters to standard SQLite3
  - Removed legacy Java applets (Marvin → MarvinJS only)
  - Added Python 3 support (Python 2 no longer supported)
  - Improved error handling with warnings instead of crashes
  - Enhanced UI with better form organization
  - Added comprehensive documentation

### ⚠️ Known Issues & Limitations

- **MATLAB dependency**: Original MATLAB scripts may need updates for current MATLAB versions
- **JAR files**: Some vendor Java files are 7+ years old; may need recompilation for modern systems
- **Python scripts**: Originally written for Python 2; adapted for Python 3 but may have compatibility issues
- **MarvinJS licensing**: ChemAxon license expires; renewal needed for production use
- **Chemistry Development Kit (CDK)**: Version 2.1.1 is outdated; consider upgrading to CDK 2.8+

### What Has Changed

**Removed:**
- ❌ JRuby support (now standard Ruby only)
- ❌ Java applet-based Marvin viewer (legacy code, 73MB)
- ❌ Python 2 support
- ❌ Old database adapters

**Updated:**
- ✅ Ruby 2.5.0 → 3.3.3
- ✅ Rails 5.2.2 → 7.1.0
- ✅ Puma 3.11 → 6.4
- ✅ All JavaScript dependencies to modern versions
- ✅ Error handling (graceful warnings instead of crashes)

**To Fully Modernize, Consider:**
- [ ] Upgrade CDK to latest version
- [ ] Review and update MATLAB scripts for current MATLAB versions
- [ ] Migrate from Carrierwave to ActiveStorage
- [ ] Add comprehensive test suite
- [ ] Implement proper authentication/authorization
- [ ] Add API endpoints for programmatic access
- [ ] Update MarvinJS to latest version (check license)
- [ ] Consider Docker containerization for deployment
